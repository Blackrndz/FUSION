/* ****************************************************************************
* $Revision: 55391 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-24 15:07:24 +0700 (Tue, 24 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Accounts.sql $:
* $Id: Manage Asset Categories - Accounts.sql 55391 2016-05-24 08:07:24Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT OrganizationUnitPEO.NAME RES_COST_ORGANIZATION
,CostBookPEO.COST_BOOK_CODE RES_COST_BOOK
,CategoryPEO.CATEGORY_NAME RES_CATEGORY_NAME
,(SELECt MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_PROFILE_CREATION_CODES'
	AND LOOKUP_CODE = DefaultCostProfileEO.PROFILE_CREATION_CODE
	) RES_NEW_ITEM_PROFILE_CREATION
,CostProfilePEO.COST_PROFILE_CODE RES_ASSET_COST_PROFILE
,CostProfilePEO1.COST_PROFILE_CODE RES_EXPENSE_COST_PROFILE
,ConsCostProfilePEO.COST_PROFILE_CODE RES_CONSIGNED_COST_PROFILE
,DefaultCostProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DefaultCostProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DefaultCostProfileEO.CREATED_BY RSC_CREATED_BY
,DefaultCostProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,DefaultCostProfileEO.COST_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_DEFAULT_COST_PROFILES DefaultCostProfileEO
,HR_ALL_ORGANIZATION_UNITS_F_VL OrganizationUnitPEO
,CST_COST_BOOKS_VL CostBookPEO
,EGP_CATEGORIES_VL CategoryPEO
,CST_COST_PROFILES_VL CostProfilePEO
,CST_COST_PROFILES_VL CostProfilePEO1
,CST_COST_PROFILES_VL ConsCostProfilePEO
WHERE DefaultCostProfileEO.COST_ORG_ID = OrganizationUnitPEO.ORGANIZATION_ID
AND SYSDATE BETWEEN OrganizationUnitPEO.EFFECTIVE_START_DATE AND OrganizationUnitPEO.EFFECTIVE_END_DATE
AND DefaultCostProfileEO.COST_BOOK_ID = CostBookPEO.COST_BOOK_ID
AND DefaultCostProfileEO.CATEGORY_ID = CategoryPEO.CATEGORY_ID(+)
AND DefaultCostProfileEO.ASSET_COST_PROFILE_ID = CostProfilePEO.COST_PROFILE_ID(+)
AND DefaultCostProfileEO.EXPENSE_COST_PROFILE_ID = CostProfilePEO1.COST_PROFILE_ID(+)
AND DefaultCostProfileEO.CONSIGNED_COST_PROFILE_ID   = ConsCostProfilePEO.COST_PROFILE_ID(+)
ORDER BY OrganizationUnitPEO.NAME 
,CostBookPEO.COST_BOOK_CODE 