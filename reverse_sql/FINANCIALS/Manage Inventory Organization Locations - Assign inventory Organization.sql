/* ****************************************************************************
 * $Revision: 78692 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-07 17:19:50 +0700 (Tue, 07 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Inventory%20Organization%20Locations%20-%20Assign%20inventory%20Organization.sql $:
 * $Id: Manage Inventory Organization Locations - Assign inventory Organization.sql 78692 2022-06-07 10:19:50Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT DISTINCT TO_CHAR(LocationDetailDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,LocationDetailTranslationDEO.LOCATION_NAME RES_NAME
,LocationEO.INTERNAL_LOCATION_CODE RES_CODE
,InventoryOrganization.ORGANIZATION_NAME RES_INVENTORY_ORGANIZATION
,LocationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LocationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LocationEO.CREATED_BY RSC_CREATED_BY
,LocationEO.CREATION_DATE RSC_CREATION_DATE	
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,LocationDetailDEO.INVENTORY_ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_LOCATIONS LocationEO
,PER_LOCATION_DETAILS_F LocationDetailDEO
,PER_LOCATION_DETAILS_F_TL LocationDetailTranslationDEO
,INV_ORGANIZATION_DEFINITIONS_V InventoryOrganization
WHERE LocationEO.LOCATION_ID = LocationDetailDEO.LOCATION_ID
AND LocationDetailDEO.LOCATION_DETAILS_ID = LocationDetailTranslationDEO.LOCATION_DETAILS_ID
AND LocationDetailDEO.EFFECTIVE_START_DATE = LocationDetailTranslationDEO.EFFECTIVE_START_DATE
AND LocationDetailTranslationDEO.LANGUAGE = userenv('LANG')
AND LocationDetailDEO.INVENTORY_ORGANIZATION_ID = InventoryOrganization.ORGANIZATION_ID
AND SYSDATE BETWEEN LocationDetailDEO.EFFECTIVE_START_DATE AND LocationDetailDEO.EFFECTIVE_END_DATE
ORDER BY LocationDetailTranslationDEO.LOCATION_NAME
,LocationEO.INTERNAL_LOCATION_CODE