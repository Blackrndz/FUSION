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
-- REPLACE_HTML_KEYWORD = RES_SUPPLEMENTAL_INFORMATION_0

SELECT compCatsE0.NAME RES_CATEGORY_NAME
,DECODE(compCatsE0.HIDE_ADDL_INFO_FLAG,'Y','Yes','No') RES_DO_NOT_DISPLAY_SUPPLEMENTA
,compCatsE0.ADDL_INFO_TITLE RES_SUPPLEMENTAL_INFORMATION_T
,REPLACE(REPLACE(REPLACE(compCatsE0.ADDL_INFO,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_SUPPLEMENTAL_INFORMATION_0
,compCatsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,compCatsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,compCatsE0.CREATED_BY RSC_CREATED_BY
,compCatsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_TCS_CAT_VL compCatsE0
WHERE compCatsE0.CAT_TYPE_CD NOT LIKE '%SECTION'
ORDER BY compCatsE0.NAME