/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Types%20-%20Classifications.sql $:
 * $Id: Manage Project Types - Classifications.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT pjfPROTypeE0.PROJECT_TYPE RES_NAME
,(SELECT CLASS_CATEGORY FROM PJF_CLASS_CATEGORIES_VL 
			WHERE CLASS_CATEGORY_ID = pjfVALIDE0.CLASS_CATEGORY_ID ) RES_CLASS_CATEGORY
 ,(SELECT DESCRIPTION FROM PJF_CLASS_CATEGORIES_VL 
			WHERE CLASS_CATEGORY_ID = pjfVALIDE0.CLASS_CATEGORY_ID ) RES_CLASS_CATEGORY_DESCRIPTION
 ,DECODE(pjfVALIDE0.MANDATORY_FLAG,'Y','Yes','No') RES_ASSIGN_TO_ALL_PROJECTS
 ,pjfVALIDE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,pjfVALIDE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,pjfVALIDE0.CREATED_BY RSC_CREATED_BY
 ,pjfVALIDE0.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECT_TYPES_VL pjfPROTypeE0
,PJF_VALID_CATEGORIES pjfVALIDE0
WHERE pjfPROTypeE0.PROJECT_TYPE_ID = pjfVALIDE0.OBJECT_TYPE_ID
ORDER BY 1
