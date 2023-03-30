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
 ,hrtContentItemEO.NAME RES_NAME
 ,(SELECT CONTENT_TYPE_NAME FROM HRT_CONTENT_TYPES_VL
		WHERE CONTENT_TYPE_ID = hrtContentItemRlatEO.RELATED_CONTENT_TYPE_ID) RES_RELATED_CONTENT_TYPE
 ,(SELECT NAME FROM HRT_CONTENT_ITEMS_VL
		WHERE CONTENT_ITEM_ID = hrtContentItemRlatEO.CONTENT_ITEM_ID) RES_CONTENT_ITEMS
 ,(SELECT MEANING FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_CODE = hrtContentItemRlatEO.RELATIONSHIP_CODE
		AND LOOKUP_TYPE = 'HRT_CONTENT_RELN_CODE'
		AND LANGUAGE = USERENV('LANG')) RES_RELATIONSHIP_TYPE
 ,(SELECT NAME FROM HRT_CONTENT_ITEMS_VL
		WHERE CONTENT_ITEM_ID = hrtContentItemRlatEO.RELATED_CONTENT_ITEM_ID) RES_RELATED_CONTENT_ITEMS
 ,TO_CHAR(hrtContentItemRlatEO.DATE_FROM,'YYYY/MM/DD') RES_FROM_DATE
 ,TO_CHAR(hrtContentItemRlatEO.DATE_TO,'YYYY/MM/DD') RES_TO_DATE
 ,hrtContentItemRlatEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtContentItemRlatEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtContentItemRlatEO.CREATED_BY RSC_CREATED_BY
 ,hrtContentItemRlatEO.CREATION_DATE RSC_CREATION_DATE
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
,HRT_CONTENT_ITEM_RLATS hrtContentItemRlatEO
WHERE hrtContentTypeEO.CONTENT_TYPE_ID = hrtContentItemEO.CONTENT_TYPE_ID
AND hrtContentTypeEO.CONTENT_TYPE_ID = hrtContentItemRlatEO.CONTENT_TYPE_ID
AND hrtContentTypeEO.BUSINESS_GROUP_ID = hrtContentItemEO.BUSINESS_GROUP_ID
AND hrtContentItemEO.CONTENT_ITEM_ID = hrtContentItemRlatEO.CONTENT_ITEM_ID
ORDER BY hrtContentTypeEO.CONTENT_TYPE_NAME


