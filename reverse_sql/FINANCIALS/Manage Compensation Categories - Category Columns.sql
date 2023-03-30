/* ****************************************************************************
* $Revision: 72658 $:
* $Author: tanawat.wongjan $:
* $Date: 2019-10-01 15:00:45 +0700 (Tue, 01 Oct 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20SCM%20Common%20Value%20Sets%20-%20Manage%20SCM%20Common%20Value%20Sets.sql $:
* $Id: Manage SCM Common Value Sets - Manage SCM Common Value Sets.sql 55804 2016-06-09 04:17:45Z wuttipong.thongvises
$:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_TCS_CAT_VL

SELECT compCatsE0.NAME RES_CATEGORY_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'CMP_TCS_LEVEL_OF_DETAIL'
	AND LOOKUP_CODE = compCatsE0.LEVEL_OF_DETAIL
	) RES_LEVEL_OF_DETAIL
,detailsE0.ORDR_NUM RES_DISPLAY_SEQUENCE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'CMP_TCS_COLS_STOCK_HISTORY'
	AND LOOKUP_CODE = detailsE0.COLUMN_TYPE_CD 
	) RES_COLUMN_TYPE
,detailsE0.DISPLAY_NAME RES_COLUMN_LABEL
,DECODE(detailsE0.AVAIL_FOR_DISP_FLAG,'Y','Yes','No') RES_AVAILABLE_FOR_DISPLAY
,DECODE(detailsE0.HIDE_COLUMN_FLAG,'N','Yes','No') RES_DISPLAY
,detailsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,detailsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,detailsE0.CREATED_BY RSC_CREATED_BY
,detailsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_TCS_CAT_VL compCatsE0
,CMP_TCS_COL_IN_CAT_VL detailsE0
WHERE compCatsE0.CAT_TYPE_CD = 'CMP_TCS_COLS_STOCK_HISTORY'
AND compCatsE0.CAT_ID = detailsE0.CAT_ID
ORDER BY compCatsE0.NAME
,detailsE0.ORDR_NUM