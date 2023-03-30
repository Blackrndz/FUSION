/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Content%20Types%20-%20Content%20Type.sql $:
 * $Id: Manage Profile Content Types - Content Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT hrtContentTypeEO.CONTEXT_NAME RES_CONTEXT_NAME
 ,DECODE(hrtContentTypeEO.FREE_FORM_FLAG,'Y','Yes','No') RES_FREE_FORM_TYPE
 ,hrtContentTypeEO.CONTENT_TYPE_NAME RES_NAME
 ,(CASE WHEN hrtContentTypeEO.MODULE_ID IS NULL
			THEN
				'Customer'
		ELSE
			'Oracle'
		END) RES_SOURCE
 ,hrtContentTypeEO.CONTENT_DESCRIPTION RES_DESCRIPTION
 ,hrtContentTypeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtContentTypeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtContentTypeEO.CREATED_BY RSC_CREATED_BY
 ,hrtContentTypeEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,hrtContentTypeEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_CONTENT_TYPES_VL hrtContentTypeEO
ORDER BY hrtContentTypeEO.CONTENT_TYPE_NAME
