/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Classification%20Categories%20-%20Entity%20Assignment.sql $:
 * $Id: Manage Classification Categories - Entity Assignment.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT CLASSCATEGORYEO.CLASS_CATEGORY RES_CLASSIFICATION_CATEGORY
,CLASSCATEGORYUSEEO.OWNER_TABLE RES_TABLE_NAME
,CLASSCATEGORYUSEEO.ADDITIONAL_WHERE_CLAUSE RES_WHERE_CLAUSE
,CLASSCATEGORYUSEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CLASSCATEGORYUSEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CLASSCATEGORYUSEEO.CREATED_BY RSC_CREATED_BY
,CLASSCATEGORYUSEEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_CLASS_CATEGORIES ClassCategoryEO
,HZ_CLASS_CATEGORY_USES CLASSCATEGORYUSEEO
WHERE CLASSCATEGORYEO.CLASS_CATEGORY = CLASSCATEGORYUSEEO.CLASS_CATEGORY
ORDER BY ClassCategoryEO.CLASS_CATEGORY