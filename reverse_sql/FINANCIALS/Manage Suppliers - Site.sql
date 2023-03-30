/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-10-12  $:
 * $HeadURL:  $:
 * $Id: Manage Suppliers - Site.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=POZ_SUPPLIER_SITES_ALL_M

SELECT DISTINCT (SELECT PersonParty.PARTY_NAME 
	FROM HZ_PARTIES PersonParty 
	,HZ_PARTY_SITES PartySitePEO
	WHERE PersonParty.PARTY_ID = PartySitePEO.PARTY_ID
	AND PartySitePEO.PARTY_SITE_ID = SupplierSiteDEO.PARTY_SITE_ID  
	) RES_SUPPLIER
,SupplierPEO.SEGMENT1 RES_SUPPLIER_NUMBER
,BusinessUnitPEO.BU_NAME RES_PROCUREMENT_BU
,SupplierSiteDEO.VENDOR_SITE_CODE RES_SITE
,SupplierSiteDEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SupplierSiteDEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SupplierSiteDEO.CREATED_BY RSC_CREATED_BY
,SupplierSiteDEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,SupplierSiteDEO.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POZ_SUPPLIER_SITES_ALL_M SupplierSiteDEO
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
,WSH_CARRIERS WshCarriers
,HZ_PARTIES PartyPEO
,HZ_PARTY_SITES PartySitePEO
,IBY_EXTERNAL_PAYEES_ALL IbyExternalPayeesAll
,POZ_SUPPLIERS SupplierPEO
WHERE SupplierSiteDEO.PARTY_SITE_ID = PartySitePEO.PARTY_SITE_ID(+)
AND SupplierSiteDEO.PRC_BU_ID = BusinessUnitPEO.BU_ID
and SupplierSiteDEO.PARTY_SITE_ID = IbyExternalPayeesAll.PARTY_SITE_ID(+)
AND SupplierSiteDEO.CARRIER_ID = WshCarriers.CARRIER_ID(+)
AND WshCarriers.CARRIER_ID = PartyPEO.PARTY_ID (+)
AND ('N' = 'N'
	OR EXISTS (SELECT 1
		FROM PO_AGENT_ACCESSES PoAgents
		WHERE PoAgents.PRC_BU_ID = BusinessUnitPEO.BU_ID
		AND PoAgents.access_action_code = 'MANAGE_SUPPLIERS'
		AND PoAgents.active_flag = 'Y'
		AND PoAgents.allowed_flag = 'Y'
		))
AND (IbyExternalPayeesAll.SUPPLIER_SITE_ID    IS not NULL )
AND SupplierPEO.VENDOR_ID = SupplierSiteDEO.VENDOR_ID
ORDER BY SupplierSiteDEO.VENDOR_SITE_CODE