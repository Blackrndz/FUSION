/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Content%20Types%20-%20Field%20Properties.sql $:
 * $Id: Manage Profile Content Types - Field Properties.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT hrtContentTypeEO.CONTEXT_NAME RES_CONTEXT_NAME
 ,hrtContentTypeEO.CONTENT_TYPE_NAME RES_NAME
 ,hrtContentPropEO.FIELD_NAME RES_FIELD_NAME
 ,hrtContentPropEO.ATTRIBUTE_LABEL RES_LABEL
 ,(CASE
		WHEN hrtContentPropEO.FIELD_NAME = 'RATING_MODEL_ID' THEN
		(SELECT RATING_NAME FROM HRT_RATING_MODELS_VL
			WHERE TO_CHAR(RATING_MODEL_ID) =  hrtContentPropEO.DEFAULT_VALUE
				AND BUSINESS_GROUP_ID =hrtContentPropEO.BUSINESS_GROUP_ID)
		ELSE
			hrtContentPropEO.DEFAULT_VALUE 
		END)RES_DEFAULT_VALUE
 ,DECODE(hrtContentPropEO.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED
 ,(SELECT MEANING FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_CODE = hrtContentPropEO.DISPLAY_CODE
		AND LOOKUP_TYPE = 'HRT_DISPLAY_CODE'
		AND LANGUAGE = USERENV('LANG')) RES_DISPLAY
 ,hrtContentPropEO.VIEW_ATTRB_NAME RES_SOURCE
 ,hrtContentPropEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtContentPropEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtContentPropEO.CREATED_BY RSC_CREATED_BY
 ,hrtContentPropEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,hrtContentPropEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_CONTENT_TYPES_VL hrtContentTypeEO
,HRT_CONTENT_PROPS_VL hrtContentPropEO
WHERE hrtContentTypeEO.CONTENT_TYPE_ID = hrtContentPropEO.CONTENT_TYPE_ID
AND hrtContentTypeEO.BUSINESS_GROUP_ID = hrtContentPropEO.BUSINESS_GROUP_ID
AND hrtContentPropEO.FIELD_NAME != 'DATE_TO'
ORDER BY hrtContentTypeEO.CONTENT_TYPE_NAME , hrtContentPropEO.FIELD_NAME

