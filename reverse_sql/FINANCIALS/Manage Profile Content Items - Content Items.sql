/* ****************************************************************************
 * $Revision: 68473 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-27 15:46:49 +0700 (Mon, 27 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20New%20Item%20Request%20Type%20Details%20-%20Assigned%20To.sql $:
 * $Id: Manage New Item Request Type Details - Assigned To.sql 68473 2018-08-27 08:46:49Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT hrtContentTypeEO.CONTENT_TYPE_NAME RES_CONTENT_TYPE
 ,hrtContentItemEO.CONTENT_ITEM_CODE RES_ITEM_CODE
 ,hrtContentItemEO.NAME RES_NAME
 ,TO_CHAR(hrtContentItemEO.DATE_FROM,'YYYY/MM/DD') RES_FROM_DATE
 ,TO_CHAR(hrtContentItemEO.DATE_TO,'YYYY/MM/DD') RES_TO_DATE
 ,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = hrtContentItemEO.CONTENT_SUPPLIER_CODE AND LOOKUP_TYPE = 'HRT_CONTENT_SUPP_CODE' AND LANGUAGE = USERENV('LANG')) RES_SUPPLIER
 ,hrtContentItemEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtContentItemEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtContentItemEO.CREATED_BY RSC_CREATED_BY
 ,hrtContentItemEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_CONTENT_TYPES_VL hrtContentTypeEO
,HRT_CONTENT_ITEMS_VL hrtContentItemEO
WHERE hrtContentTypeEO.CONTENT_TYPE_ID = hrtContentItemEO.CONTENT_TYPE_ID
AND hrtContentTypeEO.BUSINESS_GROUP_ID = hrtContentItemEO.BUSINESS_GROUP_ID
ORDER BY hrtContentTypeEO.CONTENT_TYPE_NAME,hrtContentItemEO.CONTENT_ITEM_CODE



