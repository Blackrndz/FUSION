/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Asset%20Category.sql $:
* $Id: Manage Asset Categories - Asset Category.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FA_CATEGORIES_B

-- syntax: APPLICATION_ID##RES##KFF_CODE
-- KFF_LOGIC_TO_APPLY=140##RES##CAT#
-- KFF_PREFIX_ALIAS=RES_CATEGORY
-- KFF_COLUMN_NAME=SEGMENT


SELECT SEGMENT1  RES_CATEGORY1
, SEGMENT2       RES_CATEGORY2
, SEGMENT3       RES_CATEGORY3
, SEGMENT4       RES_CATEGORY4
, SEGMENT5       RES_CATEGORY5
, SEGMENT6       RES_CATEGORY6
, SEGMENT7       RES_CATEGORY7
,(SELECT DESCRIPTION
	FROM FA_CATEGORIES_VL
	WHERE CATEGORY_ID = FaCategoryB.CATEGORY_ID
	) AS RES_DESCRIPTION
,(SELECT meaning
	FROM FND_LOOKUPS
	WHERE lookup_type = 'FA_CATEGORY_TYPE'
	AND lookup_code   = CATEGORY_TYPE
	) AS RES_CATEGORY_TYPE
,(SELECT meaning
	FROM FND_LOOKUPS
	WHERE lookup_type = 'FA_OWNLEASE'
	AND lookup_code   = OWNED_LEASED
	) AS RES_OWNERSHIP
,(SELECT meaning
	FROM FND_LOOKUPS
	WHERE lookup_type = 'FA_PROPERTY_TYPE'
	AND lookup_code   = PROPERTY_TYPE_CODE
	) AS RES_PROPERTY_TYPE
,(SELECT meaning
	FROM FND_LOOKUPS
	WHERE lookup_type = 'FA_1245_1250_PROPERTY'
	AND lookup_code   = PROPERTY_1245_1250_CODE
	) AS RES_PROPERTY_CLASS
,DECODE(FaCategoryB.CAPITALIZE_FLAG,'YES','Yes','No') AS RES_CAPITALIZED
,DECODE(FaCategoryB.ENABLED_FLAG,'Y','Yes','No') AS RES_ENABLED                         
,DECODE(FaCategoryB.INVENTORIAL,'YES','Yes','No') AS RES_IN_PHYSICAL_INVENTORY
,DECODE(FaCategoryB.INTANGIBLE_ASSET_FLAG,'Y','Yes','No') RES_INTANGIBLE
,FaCategoryB.STRUCTURE_INSTANCE_NUMBER RSC_EXTRA_COLUMN1
,FaCategoryB.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,FaCategoryB.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,FaCategoryB.CREATED_BY RSC_CREATED_BY
,FaCategoryB.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_CATEGORIES_B FaCategoryB
ORDER BY RES_CATEGORY1