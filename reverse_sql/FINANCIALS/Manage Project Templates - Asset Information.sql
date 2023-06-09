/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Asset%20Information.sql $:
* $Id: Manage Project Templates - Asset Information.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,projAssetsE0.ASSET_NAME RES_ASSET_NAME
,(SELECT MEANING
    FROM FND_LOOKUPS
    WHERE LOOKUP_TYPE = 'PJC_PROJECT_ASSET_TYPES'
    AND LOOKUP_CODE = projAssetsE0.PROJECT_ASSET_TYPE
    ) RES_PROJECT_ASSET_TYPE
,TO_CHAR(projAssetsE0.ESTIMATED_IN_SERVICE_DATE,'DD-Mon-YYYY') RES_ESTIMATED_IN_SERVICE_DATE
,TO_CHAR(projAssetsE0.DATE_PLACED_IN_SERVICE,'DD-Mon-YYYY') RES_ACTUAL_IN_SERVICE_DATE
,DECODE(projAssetsE0.CAPITAL_HOLD_FLAG,'Y','Yes','No') RES_CAPITAL_HOLD
,DECODE(projAssetsE0.REVERSE_FLAG,'Y','Yes','No') RES_REVERSE
,projAssetsE0.ASSET_DESCRIPTION RES_DESCRIPTION
,(SELECT ASSET_NUMBER
    FROM FA_ADDITIONS_B
    WHERE ASSET_ID = projAssetsE0.RET_TARGET_ASSET_ID
    ) RES_TARGET_ASSET
,(SELECT BOOK_TYPE_NAME
    FROM FA_BOOK_CONTROLS
    WHERE BOOK_TYPE_CODE = projAssetsE0.BOOK_TYPE_CODE
    ) RES_BOOK
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'FA'
    ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= assetCategoriesE0.STRUCTURE_INSTANCE_NUMBER)
    ,STRUCTURE_NUMBER => assetCategoriesE0.STRUCTURE_INSTANCE_NUMBER
    ,COMBINATION_ID => assetCategoriesE0.CATEGORY_ID) RES_ASSET_CATEGORY
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'FA'
    ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= assetKeysE0.STRUCTURE_INSTANCE_NUMBER)
    ,STRUCTURE_NUMBER => assetKeysE0.STRUCTURE_INSTANCE_NUMBER
    ,COMBINATION_ID => assetKeysE0.CODE_COMBINATION_ID) RES_ASSET_KEY
,projAssetsE0.ASSET_NUMBER RES_ASSET_NUMBER
,(SELECT DESCRIPTION
    FROM FA_ADDITIONS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND ASSET_ID = projAssetsE0.PARENT_ASSET_ID
    ) RES_PARENT_ASSET
,projAssetsE0.ESTIMATED_ASSET_UNITS RES_ESTIMATED_UNITS
,projAssetsE0.ASSET_UNITS RES_ACTUAL_UNITS
,projAssetsE0.ESTIMATED_COST RES_ESTIMATED_COST
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'FA'
    ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= assetLocationsE0.STRUCTURE_INSTANCE_NUMBER)
    ,STRUCTURE_NUMBER =>	assetLocationsE0.STRUCTURE_INSTANCE_NUMBER
    ,COMBINATION_ID => assetLocationsE0.LOCATION_ID) RES_LOCATION
,(SELECT FULL_NAME
    FROM PER_PERSON_NAMES_F
    WHERE NAME_TYPE = 'GLOBAL'
    AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND PERSON_ID = projAssetsE0.ASSIGNED_TO_PERSON_ID
    ) RES_PERSON
,DECODE(projAssetsE0.DEPRECIATE_FLAG,'Y','Yes','No') RES_DEPRECIATE
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
    ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= codeCombinationsE0.CHART_OF_ACCOUNTS_ID)
    ,STRUCTURE_NUMBER =>	codeCombinationsE0.CHART_OF_ACCOUNTS_ID
    ,COMBINATION_ID => codeCombinationsE0.CODE_COMBINATION_ID) RES_DEPRECIATION_EXPENSE_ACCOU
,DECODE(projAssetsE0.AMORTIZE_FLAG,'Y','Yes','No') RES_AMORTIZE_ADJUSTMENTS
,projAssetsE0.MANUFACTURER_NAME RES_MANUFACTURER
,projAssetsE0.MODEL_NUMBER RES_MODEL_NUMBER
,projAssetsE0.SERIAL_NUMBER RES_SERIAL_NUMBER
,projAssetsE0.TAG_NUMBER RES_TAG_NUMBER
,projAssetsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,projAssetsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,projAssetsE0.CREATED_BY  RSC_CREATED_BY
,projAssetsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJC_PRJ_ASSETS_ALL projAssetsE0
,FA_CATEGORIES_B assetCategoriesE0
,FA_ASSET_KEYWORDS assetKeysE0
,GL_CODE_COMBINATIONS codeCombinationsE0
,FA_LOCATIONS assetLocationsE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = projAssetsE0.PROJECT_ID
AND projAssetsE0.ASSET_CATEGORY_ID = assetCategoriesE0.CATEGORY_ID(+)
AND projAssetsE0.ASSET_KEY_CCID = assetKeysE0.CODE_COMBINATION_ID(+)
AND projAssetsE0.DEPRECIATION_EXPENSE_CCID = codeCombinationsE0.CODE_COMBINATION_ID(+)
AND projAssetsE0.LOCATION_ID = assetLocationsE0.LOCATION_ID(+)
ORDER BY projTemplatesE0.NAME
,projAssetsE0.ASSET_NAME