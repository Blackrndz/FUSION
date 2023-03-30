/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PartyEO.PARTY_NAME RES_CARRIER_NAME
,ServiceLevelEO.MEANING RES_SERVICE_LEVEL
,ModeOfTransportEO.MEANING RES_MODE_OF_TRANSPORT
,OrgDefPE1_1.ORGANIZATION_CODE RES_ORGANIZATION
,OrgDefPE1_1.ORGANIZATION_NAME RES_ORGANIZATION_NAME
,WarehouseCarrierServiceE1.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WarehouseCarrierServiceE1.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WarehouseCarrierServiceE1.CREATED_BY RSC_CREATED_BY
,WarehouseCarrierServiceE1.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,WarehouseCarrierServiceE1.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_CARRIERS CarrierEO
,HZ_PARTIES PartyEO
,WSH_ORG_CARRIER_SERVICES WarehouseCarrierServiceEO
,WSH_ORG_CARRIER_SERVICES WarehouseCarrierServiceE1
,RCS_LOOKUPS ServiceLevelEO
,RCS_LOOKUPS ModeOfTransportEO
,INV_ORGANIZATION_DEFINITIONS_V OrgDefPE1_1
WHERE CarrierEO.CARRIER_ID                      = PartyEO.PARTY_ID
AND CarrierEO.CARRIER_ID                        = WarehouseCarrierServiceEO.CARRIER_ID
AND WarehouseCarrierServiceEO.SERVICE_LEVEL     = ServiceLevelEO.LOOKUP_CODE(+)
AND ServiceLevelEO.LOOKUP_TYPE                  = 'WSH_SERVICE_LEVELS'
AND WarehouseCarrierServiceEO.MODE_OF_TRANSPORT = ModeOfTransportEO.LOOKUP_CODE(+)
AND ModeOfTransportEO.LOOKUP_TYPE               = 'WSH_MODE_OF_TRANSPORT'
AND WarehouseCarrierServiceEO.ORGANIZATION_ID  IS NULL
AND WarehouseCarrierServiceEO.ORG_CARRIER_SERVICE_ID = WarehouseCarrierServiceE1.PARENT_ID
AND WarehouseCarrierServiceE1.ORGANIZATION_ID = OrgDefPE1_1.ORGANIZATION_ID
ORDER BY PartyEO.PARTY_NAME
,ServiceLevelEO.MEANING
,OrgDefPE1_1.ORGANIZATION_CODE