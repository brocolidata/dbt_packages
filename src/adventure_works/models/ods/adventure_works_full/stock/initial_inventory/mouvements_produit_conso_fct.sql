with stk_init as (
    select *
    from {{ ref('stock_initial_calcule_fct') }}
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
        cast(date_month as Date) as date_month,
        stock_init
    from stk_init
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
        coalesce(pr.date_month, quc.date_monthc) as date_mouvement,
        coalesce(pr.id_produit, quc.id_composant) as id_produit,
        sum(quc.quantite_consommee) as quantite_consommee,
        sum(pr.stock_init) as stock_initial

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
        coalesce(
            cs.id_produit,
            qua.id_produita,
            qup.id_produitp,
            qur.id_produitr,
            quv.id_produitv
        ) as id_produit,
        coalesce(
            cs.date_mouvement,
            qua.date_montha,
            qup.date_monthp,
            qur.date_monthr,
            quv.date_monthv
        ) as date_mouvement,
        sum(coalesce(cs.stock_initial, 0)) as stock_initial,
        sum(coalesce(qua.quantite_achetee, 0)) as quantite_achetee,
        sum(coalesce(cs.quantite_consommee, 0)) as quantite_consommee,
        sum(coalesce(qup.quantite_produite, 0)) as quantite_produite,
        sum(coalesce(qur.quantite_rejetee, 0)) as quantite_rejetee,
        sum(coalesce(quv.quantite_vendue, 0)) as quantite_vendue


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
        (
            mv.quantite_consommee
            + mv.quantite_rejetee
            + mv.quantite_vendue
        ) as quantite_sortie,
        mv.quantite_produite + mv.quantite_achetee as quantite_entree,
        (
            mv.stock_initial
            + mv.quantite_achetee
            - mv.quantite_consommee
            - mv.quantite_rejetee
            - mv.quantite_vendue
            + mv.quantite_produite
        ) as quantite_restante

    from mouvements as mv
),

quantit_rest_avec_inv as (

    select
        qr.* except(
            stock_initial,
            quantite_achetee,
            quantite_consommee,
            quantite_produite,
            quantite_rejetee,
            quantite_vendue,
            quantite_restante,
            quantite_sortie,
            quantite_entree
        ),

        qr.stock_initial as stock_initial,
        qr.quantite_entree as quantite_entree,
        qr.quantite_sortie as quantite_sortie,
        qr.quantite_restante as quantite_restante,
        sum(
            qr.quantite_restante
        ) over (
            partition by id_produit order by date_mouvement
        ) as running_quantite_restante

    from quantite_rest as qr
),


avec_inv as (

    select
        q.* except(
            stock_initial,
            date_mouvement,
            quantite_restante,
            quantite_sortie,
            quantite_entree
        ),
        q.stock_initial as stock_initial,
        q.quantite_entree as quantite_entree,
        q.quantite_sortie as quantite_sortie,
        q.quantite_restante as quantite_restante,
        case
            when
                q.running_quantite_restante = min(
                    q.running_quantite_restante
                ) over(
                    partition by id_produit
                ) and min(
                    q.running_quantite_restante
                ) over(partition by id_produit) < 0
                then min(q.date_mouvement) over(partition by id_produit)
            else q.date_mouvement
        end as date_mouvement,
        case
            when
                q.running_quantite_restante = min(
                    q.running_quantite_restante
                ) over(
                    partition by id_produit
                ) and q.running_quantite_restante < 0
                then abs(q.running_quantite_restante)
            else 0
        end as quantite_ajustement
    from quantit_rest_avec_inv as q
),

inv as (

    select
        i.id_produit,
        i.date_mouvement,
        i.quantite_entree as quantite_entree,
        i.quantite_sortie as quantite_sortie,
        case
            when i.quantite_ajustement != 0
                then sum(i.quantite_ajustement) over(partition by id_produit)
            else i.stock_initial
        end as stock_initial

    from avec_inv as i
),

etat as (

    select
        e.id_produit,
        e.date_mouvement,
        sum(e.stock_initial) as stock_initial,
        sum(e.quantite_entree) as quantite_entree,
        sum(e.quantite_sortie) as quantite_sortie,
        sum(
            e.stock_initial + e.quantite_entree - e.quantite_sortie
        ) as quantite_restante

    from inv as e
    group by id_produit, date_mouvement
),

etat_final as (

    select
        ef.id_produit,
        ef.date_mouvement,
        ef.stock_initial as stock_initial,
        ef.quantite_entree as quantite_entree,
        ef.quantite_sortie as quantite_sortie,
        ef.quantite_restante as quantite_restante,
        sum(
            ef.quantite_restante
        ) over (
            partition by id_produit order by date_mouvement
        ) as running_quantite_restante

    from etat as ef
)


select * from etat_final order by id_produit asc, date_mouvement asc
