with sales_order_header_prp as (
    select * from {{ ref('SalesOrderHeader_prp') }}
),

taux_change_fct as (
    select * from {{ ref('taux_change_aw_fct') }}
),

territoire_vente_dim as (
    select 
        ID_territoire,
        nom_territoire,
        code_region,
        zone_geographique
    from {{ ref('territoire_vente_dim') }}
),

sales_order_header as (
    select
        ID_commande,
        date_commande,
        date_echeance,
        date_expedition,
        est_une_commande_internet,
        ID_client,
        ID_vendeur,
        ID_territoire,
        ID_methode_livraison,
        ID_taux_change,
        sous_total,
        montant_taxe,
        fret,
        total
    from sales_order_header_prp
),

taux_change as (
    select 
        ID_taux_change,
        date_taux_change,
        change_depuis,
        change_vers,
        taux_change_moyen,
        taux_change_fin_journee
    from taux_change_fct
),
{# 
    TODO : add the following joins : 
    -  ShipMethod
#}
en_tete_commande as (
    select 
        soh.* except (ID_taux_change),
        tc.*,
        tv.* except(ID_territoire)
    from sales_order_header soh
    left join taux_change tc on soh.ID_taux_change = tc.ID_taux_change
    left join territoire_vente_dim tv on soh.ID_territoire = tv.ID_territoire
)

select * from en_tete_commande