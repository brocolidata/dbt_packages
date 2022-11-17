with  stk_final as (
    select * 
        from {{ ref('stock_final_fct') }}
),


qcc as (
    select * 
        from {{ ref('stock_consomme_fct') }}
),

qaa as (
    select * 
        from {{ ref('stock_achete_fct') }}
),

qpp as (
    select * 
        from {{ ref('stock_produit_fct') }}
),

qrr as (
    select * 
        from {{ ref('stock_rejete_fct') }}
),

qvv as (
    select * 
        from {{ ref('stock_vendu_fct') }}
),

qf as (
    select
        id_produit,
        date_month,
        stock_final
    from stk_final
),

qc as (
    select
        date_month as date_monthc,
        id_composant,
        quantite_consommee
        
    from qcc
),

qa as (
    select
        date_month as date_montha,
        id_produit as id_produita,
        quantite_achetee
        
    from qaa
),

qp as (
    select
        date_month as date_monthp,
        id_produit as id_produitp,
        quantite_produite
        
    from qpp
),

qr as (
    select
        date_month as date_monthr,
        id_produit as id_produitr,
        quantite_rejetee
        
    from qrr
),

qv as (
    select
        date_month as date_monthv,
        id_produit as id_produitv,
        quantite_vendue
        
    from qvv
),



conso as (
    select
        coalesce(pr.date_month,quc.date_monthc) as date_mouvement,
        coalesce(pr.id_produit,quc.id_composant) as id_produit,
        sum(IFNULL(quc.quantite_consommee,0)) as quantite_consommee,
        sum(IFNULL(pr.stock_final,0)) as stock_final
        
        -- qua.* except(id_produita), 
        -- qup.* except(id_produitp), 
        -- qur.* except(id_produitr), 
        -- quv.* except(id_produitv)
        

    from qf as pr 
    full join qc as quc 
        on pr.date_month = quc.date_monthc
            and pr.id_produit = quc.id_composant
                
    group by id_produit, date_mouvement
                
    -- left join qa as qua 
    --         on pr.id_produit = qua.id_produita
    -- left join qp as qup
    --         on pr.id_produit = qup.id_produitp  
    -- left join qr as qur
    --         on pr.id_produit = qur.id_produitr
    -- left join qv as quv
    --         on pr.id_produit = quv.id_produitv
    
),

mouvements as (
    select
        coalesce(cs.id_produit, qua.id_produita, qup.id_produitp, qur.id_produitr, quv.id_produitv) as id_produit,
        coalesce(cs.date_mouvement, qua.date_montha ,qup.date_monthp, qur.date_monthr, quv.date_monthv) as date_mouvement,
        sum(IFNULL(cs.stock_final,0)) as stock_final,
        sum(IFNULL(qua.quantite_achetee,0)) as quantite_achetee,
        sum(IFNULL(cs.quantite_consommee,0)) as quantite_consommee,
        sum(IFNULL(qup.quantite_produite,0)) as quantite_produite,
        sum(IFNULL(qur.quantite_rejetee,0)) as quantite_rejetee,
        sum(IFNULL(quv.quantite_vendue,0)) as quantite_vendue
        

    from conso as cs
    full join qa as qua 
        on cs.date_mouvement = qua.date_montha
            and cs.id_produit = qua.id_produita
    full join qp as qup 
        on cs.date_mouvement = qup.date_monthp
            and cs.id_produit = qup.id_produitp
    full join qr as qur 
        on cs.date_mouvement = qur.date_monthr
            and cs.id_produit = qur.id_produitr
    full join qv as quv 
        on cs.date_mouvement = quv.date_monthv
            and cs.id_produit = quv.id_produitv
    


    group by id_produit, date_mouvement
),

quantite_rest as (

    select 
        mv.*,
        mv.quantite_consommee + mv.quantite_rejetee + mv.quantite_vendue as quantite_sortie,
        mv.quantite_produite + mv.quantite_achetee as quantite_entree,
        mv.quantite_achetee - mv.quantite_consommee - mv.quantite_rejetee - mv.quantite_vendue + mv.quantite_produite as quantite_restante

    from mouvements as mv
),

quantit_rest_avec_inv as(

    select 
        qr.* except(stock_final, quantite_achetee, quantite_consommee, quantite_produite, quantite_rejetee, quantite_vendue, quantite_restante, quantite_sortie, quantite_entree),

        case
            when qr.quantite_entree<0 then 0
            else qr.quantite_entree
        end as quantite_entree,
        case
            when qr.quantite_sortie<0 then 0
            else qr.quantite_sortie
        end as quantite_sortie,
            
        qr.quantite_restante as quantite_restante
    from quantite_rest as qr
) 
select * from quantit_rest_avec_inv order by id_produit asc, date_mouvement asc
