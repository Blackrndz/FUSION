/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Item%20Catalog%20-%20Item%20Catalog.sql $:
 * $Id: Manage Profile Item Catalog - Item Catalog.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
-- RSC_PREREQUISITE_OBJECTS=HRT_CONTENT_TP_VALUESETS_VL
 
SELECT  (SELECT CONTENT_TYPE_NAME FROM HRT_CONTENT_TYPES_VL WHERE CONTENT_TYPE_ID = hrtCONTPVALUESETEO.CONTENT_TYPE_ID) RES_TEMPLATE_NAME
,hrtCONTPVALUESETEO.VALUE_SET_NAME RES_ITEM_CATALOG_NAME
,hrtCONTPVALUESETEO.VALUE_SET_DESCRIPTION RES_DESCRIPTION

,hrtCONTPVALUESETEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hrtCONTPVALUESETEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hrtCONTPVALUESETEO.CREATED_BY RSC_CREATED_BY
,hrtCONTPVALUESETEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_CONTENT_TP_VALUESETS_VL hrtCONTPVALUESETEO 
ORDER BY RES_TEMPLATE_NAME
