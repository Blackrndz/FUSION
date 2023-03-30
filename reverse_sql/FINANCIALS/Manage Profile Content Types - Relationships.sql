/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Content%20Types%20-%20Relationships.sql $:
 * $Id: Manage Profile Content Types - Relationships.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS=HRT_CONTENT_TYPE_RLATS
 
SELECT hrtContentTypeEO.CONTEXT_NAME RES_CONTEXT_NAME 
 ,hrtContentTypeEO.CONTENT_TYPE_NAME RES_NAME
 ,(SELECT MEANING FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_CODE = hrtContentTypeRlatEO.RELATIONSHIP_CODE
		AND LOOKUP_TYPE = 'HRT_CONTENT_RELN_CODE'
		AND LANGUAGE = USERENV('LANG')) RES_RELATIONSHIP
 ,(SELECT CONTENT_DESCRIPTION FROM HRT_CONTENT_TYPES_VL
	WHERE CONTENT_TYPE_ID = hrtContentTypeRlatEO.RELATED_CONTENT_TYPE_ID ) RES_RELATED_CONTENT_TYPE
 ,TO_CHAR(hrtContentTypeRlatEO.DATE_FROM,'YYYY/MM/DD') RES_DATE_FROM
 ,TO_CHAR(hrtContentTypeRlatEO.DATE_TO,'YYYY/MM/DD') RES_DATE_TO
 ,DECODE(hrtContentTypeRlatEO.RATING_INTERACTION_TYPE,'ORA_AVERAGE','Average',NULL) RES_PROFICIENCY_CALCULATION_RU
 ,(SELECT CONTENT_DESCRIPTION FROM HRT_CONTENT_TYPES_VL
	WHERE CONTENT_TYPE_ID = hrtContentTypeRlatEO.RELATED_CONTENT_TYPE_ID ) RES_DESCRIPTION
 ,hrtContentTypeRlatEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtContentTypeRlatEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtContentTypeRlatEO.CREATED_BY RSC_CREATED_BY
 ,hrtContentTypeRlatEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,hrtContentTypeRlatEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_CONTENT_TYPES_VL hrtContentTypeEO
,HRT_CONTENT_TYPE_RLATS hrtContentTypeRlatEO
WHERE hrtContentTypeEO.CONTENT_TYPE_ID = hrtContentTypeRlatEO.CONTENT_TYPE_ID
AND hrtContentTypeEO.BUSINESS_GROUP_ID = hrtContentTypeRlatEO.BUSINESS_GROUP_ID
ORDER BY hrtContentTypeEO.CONTENT_TYPE_NAME


