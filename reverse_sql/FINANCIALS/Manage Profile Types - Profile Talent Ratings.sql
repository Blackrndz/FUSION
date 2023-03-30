/* ****************************************************************************
 * $Revision: 68523 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-30 14:33:44 +0700 (Thu, 30 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Priority%20Values%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Project Priority Values - Lookup Codes.sql 68523 2018-08-30 07:33:44Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=HRT_PROFILE_TYPES_VL
--RSC_PREREQUISITE_OBJECTS=HRT_PROFILE_TYP_SECTIONS_VL
 
SELECT profileTypesE0.PROFILE_TYPE_CODE RES_PROFILE_TYPE
,contentSelectionsE0.NAME RES_SECTION_NAME
,contentSelectionsE0.DESCRIPTION RES_SECTION_DESCRIPTION
,DECODE(contentSelectionsE0.ACTIVE_FLAG,'Y','Yes','No') RES_ACTIVE
,contentSelectionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contentSelectionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contentSelectionsE0.CREATED_BY RSC_CREATED_BY
,contentSelectionsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,profileTypesE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_PROFILE_TYPES_VL profileTypesE0
,(SELECT DISPLAY_ORDER
	,PROFILE_TYPE_ID
	,BUSINESS_GROUP_ID
	,CONTENT_TYPE_ID
	,NAME
	,DESCRIPTION
	,APPROVAL_REQUIRED_FLAG
	,ACTIVE_FLAG
	,LINKEDIN_ENABLED_FLAG
	,LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
	,ROW_NUMBER() OVER(PARTITION BY PROFILE_TYPE_ID,BUSINESS_GROUP_ID ORDER BY DISPLAY_ORDER) R1
	FROM HRT_PROFILE_TYP_SECTIONS_VL 
	WHERE NAME IS NOT NULL
	AND SECURITY_CONTEXT IN ('N_BOX_ASSIGNMENT','POTENTIAL','ADVANCEMENT_READINESS','RISK','PERFORMANCE_RATING','TALENT_SCORE')
	--AND PARENT_SECTION_ID IS NULL
	) contentSelectionsE0
,HRT_CONTENT_TYPES_VL contentsE0
WHERE profileTypesE0.PROFILE_USAGE_CODE NOT IN ('T','R')
AND profileTypesE0.PROFILE_TYPE_ID = contentSelectionsE0.PROFILE_TYPE_ID
AND profileTypesE0.BUSINESS_GROUP_ID = contentSelectionsE0.BUSINESS_GROUP_ID
AND contentSelectionsE0.CONTENT_TYPE_ID = contentsE0.CONTENT_TYPE_ID
AND contentSelectionsE0.BUSINESS_GROUP_ID = contentsE0.BUSINESS_GROUP_ID
ORDER BY profileTypesE0.PROFILE_TYPE_CODE
,contentSelectionsE0.DISPLAY_ORDER 