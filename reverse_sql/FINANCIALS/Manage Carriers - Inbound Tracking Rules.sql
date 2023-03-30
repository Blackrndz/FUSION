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
,CarrierTrackingEO.TRACKING_RULE_NAME RES_NAME
,CarrierTrackingEO.BASE_URL RES_BASE_URL
,RequestMethodEO.MEANING RES_REQUEST_METHOD
,DECODE(CarrierTrackingEO.ENABLED_FLAG, 'Y', 'Yes', 'No') RES_ACTIVE
,CarrierTrackingEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CarrierTrackingEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CarrierTrackingEO.CREATED_BY RSC_CREATED_BY
,CarrierTrackingEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_CARRIERS CarrierEO
,HZ_PARTIES PartyEO
,WSH_CAR_ORG_TRACKINGS CarrierTrackingEO
,RCS_LOOKUPS RequestMethodEO
WHERE CarrierEO.CARRIER_ID = PartyEO.PARTY_ID
AND CarrierEO.CARRIER_ID   = CarrierTrackingEO.CARRIER_ID
AND CarrierTrackingEO.REQUEST_METHOD = RequestMethodEO.LOOKUP_CODE
AND RequestMethodEO.LOOKUP_TYPE        = 'WSH_TRACKING_METHODS'
AND CarrierTrackingEO.ORGANIZATION_ID IS NULL
ORDER BY PartyEO.PARTY_NAME
,CarrierTrackingEO.TRACKING_RULE_NAME