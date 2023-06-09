/* ****************************************************************************
* $Revision: 80294 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2023-02-23 10:05:55 +0700 (Thu, 23 Feb 2023) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Default%20Rules.sql $:
* $Id: Manage Asset Categories - Default Rules.sql 80294 2023-02-23 03:05:55Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FA_CATEGORY_BOOK_DEFAULTS

SELECT faCatsE0.SEGMENT1 AS RES_CATEGORY1
,faCatsE0.SEGMENT2 AS RES_CATEGORY2
,faCatsE0.SEGMENT3 AS RES_CATEGORY3
,faCatsE0.SEGMENT4 AS RES_CATEGORY4
,faCatsE0.SEGMENT5 AS RES_CATEGORY5
,faCatsE0.SEGMENT6 AS RES_CATEGORY6
,faCatsE0.SEGMENT7 AS RES_CATEGORY7
,CategoryBookDefaultEO.BOOK_TYPE_CODE                    AS RES_BOOK ,
  TO_CHAR(CategoryBookDefaultEO.START_DPIS,'DD-Mon-YYYY') AS RES_FROM_DATE_PLACED_IN_SERVIC ,
  NVL((SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'FA_YESNO'
  AND lookup_code   = CategoryBookDefaultEO.DEPRECIATE_FLAG
  ),'No') AS RES_DEPRECIATE ,
  (SELECT METHOD_CODE
  FROM FA_METHODS
  WHERE METHOD_ID = CategoryBookDefaultEO.METHOD_ID
  )                                         AS RES_DEPRECIATION_METHOD ,
  (SELECT UNIT_OF_MEASURE
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = CategoryBookDefaultEO.UNIT_OF_MEASURE     
	) AS RES_UNIT_OF_MEASURE ,
  CategoryBookDefaultEO.PRODUCTION_CAPACITY AS RES_PRODUCTION_CAPACITY ,
  (SELECT TRUNC(life_in_months / 12)
  FROM FA_METHODS
  WHERE METHOD_ID = CategoryBookDefaultEO.METHOD_ID
  ) AS RES_LIFE_IN_YEARS ,
  (SELECT ROUND(mod(life_in_months,12))
  FROM FA_METHODS
  WHERE METHOD_ID = CategoryBookDefaultEO.METHOD_ID
  ) AS RES_LIFE_IN_MONTHS ,
  (SELECT(BASIC_RATE * 100)
  FROM FA_FLAT_RATES
  WHERE FLAT_RATE_ID = CategoryBookDefaultEO.FLAT_RATE_ID
  ) AS RES_BASIC_RATE ,
  (SELECT(ADJUSTED_RATE * 100)
  FROM FA_FLAT_RATES
  WHERE FLAT_RATE_ID = CategoryBookDefaultEO.FLAT_RATE_ID
  ) AS RES_ADJUSTED_RATE ,
  (SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'FA_DEPRN_LIMIT_TYPE'
  AND lookup_code   = CategoryBookDefaultEO.DEPRN_LIMIT_TYPE
  )                                                                                                                                                                   AS RES_DEPRECIATION_LIMIT_TYPE ,
  DECODE(CategoryBookDefaultEO.DEPRN_LIMIT_TYPE,'PCT',(CategoryBookDefaultEO.ALLOWED_DEPRN_LIMIT * 100),'AMT', CategoryBookDefaultEO.SPECIAL_DEPRN_LIMIT_AMOUNT,NULL) AS RES_DEPRECIATION_LIMITPERCENT ,
  (SELECT BONUS_RULE
  FROM FA_BONUS_RULES
  WHERE BONUS_RULE_ID = CategoryBookDefaultEO.BONUS_RULE_ID
  ) AS RES_BONUS_RULE ,
  (SELECT PRORATE_CONVENTION_CODE
  FROM FA_CONVENTION_TYPES
  WHERE CONVENTION_TYPE_ID = CategoryBookDefaultEO.CONVENTION_TYPE_ID
  ) AS RES_PRORATE_CONVENTION ,
  (SELECT PRORATE_CONVENTION_CODE
  FROM FA_CONVENTION_TYPES
  WHERE CONVENTION_TYPE_ID = CategoryBookDefaultEO.RETIREMENT_CONVENTION_TYPE_ID
  )                                                   AS RES_RETIREMENT_CONVENTION ,
  (CategoryBookDefaultEO.PERCENT_SALVAGE_VALUE * 100) AS RES_DEFAULT_SALVAGE_PERCENT ,
  (SELECT CEILING_NAME
  FROM FA_CEILING_TYPES
  WHERE CEILING_TYPE_ID = CategoryBookDefaultEO.CEILING_TYPE_ID
  )                                                           AS RES_DEPRECIATION_CEILING ,
  TRUNC(CategoryBookDefaultEO.CAPITAL_GAIN_THRESHOLD / 12)    AS RES_CAPITAL_GAINS_THRESHOLD_YE ,
  ROUND(mod(CategoryBookDefaultEO.CAPITAL_GAIN_THRESHOLD,12)) AS RES_CAPITAL_GAINS_THRESHOLD__0 ,
  (SELECT PRICE_INDEX_NAME
  FROM FA_PRICE_INDEXES
  WHERE PRICE_INDEX_ID = CategoryBookDefaultEO.PRICE_INDEX_ID
  ) AS RES_PRICE_INDEX ,
  NVL((SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'YES_NO'
  AND lookup_code   = CategoryBookDefaultEO.MASS_PROPERTY_FLAG
  ),'No')                                                                            AS RES_MASS_PROPERTY_ELIGIBLE ,
  DECODE(CategoryBookDefaultEO.USE_STL_RETIREMENTS_FLAG,'YES','Yes','NO',NULL) AS RES_ALLOW_STRAIGHT_LINE_FOR_RE ,
  (SELECT METHOD_CODE
  FROM FA_METHODS
  WHERE METHOD_ID = CategoryBookDefaultEO.STL_METHOD_ID
  ) AS RES_TAX_INFORMATION_DEPRECIATI ,
  (SELECT TRUNC(life_in_months / 12)
  FROM FA_METHODS
  WHERE METHOD_ID = CategoryBookDefaultEO.STL_METHOD_ID
  ) AS RES_TAX_INFORMATION_LIFE_IN_YE ,
  (SELECT ROUND(mod(life_in_months,12))
  FROM FA_METHODS
  WHERE METHOD_ID = CategoryBookDefaultEO.STL_METHOD_ID
  ) AS RES_TAX_INFORMATION_LIFE_IN_MO ,
  (SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'FA_SUBCOMPONENT_LIFE_RULE'
  AND lookup_code   = CategoryBookDefaultEO.SUBCOMPONENT_LIFE_RULE
  )                                                           AS RES_RULE ,
  TRUNC(CategoryBookDefaultEO.MINIMUM_LIFE_IN_MONTHS / 12)    AS RES_MINIMUM_YEARS ,
  ROUND(mod(CategoryBookDefaultEO.MINIMUM_LIFE_IN_MONTHS,12)) AS RES_MINIMUM_YEARS_MONTHS ,
  
  CategoryBookDefaultEO.CAP_THRESHOLD_AMOUNT RES_LOW_VALUE_ASSET_CAPITALIZA,
  CategoryBookDefaultEO.LOW_VALUE_THRESHOLD_AMOUNT RES_LOW_VALUE_ASSET_LOW_VALUE_,
  (SELECT METHOD_CODE
	FROM FA_METHODS
	WHERE METHOD_ID = CategoryBookDefaultEO.LVA_METHOD_ID
	) RES_LOW_VALUE_ASSET_METHOD,
  (SELECT TRUNC(life_in_months / 12)
	FROM FA_METHODS
	WHERE METHOD_ID = CategoryBookDefaultEO.LVA_METHOD_ID
	) RES_LOW_VALUE_ASSET_LIFE_IN_YE,
  (SELECT ROUND(mod(life_in_months,12))
	FROM FA_METHODS
	WHERE METHOD_ID = CategoryBookDefaultEO.LVA_METHOD_ID
	) RES_LOW_VALUE_ASSET_LIFE_IN_MO,
  (SELECT(BASIC_RATE * 100)
	FROM FA_FLAT_RATES
	WHERE FLAT_RATE_ID = CategoryBookDefaultEO.LVA_FLAT_RATE_ID 
	) RES_LOW_VALUE_ASSET_BASIC_RATE,
  (SELECT(ADJUSTED_RATE * 100)
	FROM FA_FLAT_RATES
	WHERE FLAT_RATE_ID = CategoryBookDefaultEO.LVA_FLAT_RATE_ID
	) RES_LOW_VALUE_ASSET_ADJUSTED_R,
  (SELECT PRORATE_CONVENTION_CODE
	FROM FA_CONVENTION_TYPES
	WHERE CONVENTION_TYPE_ID = CategoryBookDefaultEO.LVA_CONVENTION_TYPE_ID 
	) RES_LOW_VALUE_ASSET_PRORATE_CO,
  
  
  (SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'FA_RECOGNIZE_GAIN_LOSS'
  AND lookup_code   = CategoryBookDefaultEO.RECOGNIZE_GAIN_LOSS
  ) AS RES_RECOGNIZE_GAIN_OR_LOSS ,
  (SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'FA_TERMINAL_GAIN_LOSS'
  AND lookup_code   = CategoryBookDefaultEO.TERMINAL_GAIN_LOSS
  ) AS RES_TERMINAL_GAIN_OR_LOSS ,
  NVL((SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'YES_NO'
  AND lookup_code   = CategoryBookDefaultEO.RECAPTURE_RESERVE_FLAG
  ),'No') AS RES_RECAPTURE_EXCESS_RESERVE ,
  NVL((SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'YES_NO'
  AND lookup_code   = CategoryBookDefaultEO.LIMIT_PROCEEDS_FLAG
  ),'No') AS RES_LIMIT_NET_PROCEEDS_TO_COST ,
  (SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'FA_TRACKING_METHOD'
  AND lookup_code   = CategoryBookDefaultEO.TRACKING_METHOD
  ) AS RES_TRACKING_METHOD ,
  (SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'FA_DEPRECIATION_OPTION'
  AND lookup_code   = CategoryBookDefaultEO.DEPRECIATION_OPTION
  ) AS RES_DEPRECIATE_BY ,
  NVL((SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'YES_NO'
  AND lookup_code   = CategoryBookDefaultEO.MEMBER_ROLLUP_FLAG
  ),'No') AS RES_SUM_MEMBER_ASSET_DEPRECIAT ,
  NVL((SELECT meaning
  FROM FND_LOOKUPS
  WHERE lookup_type = 'YES_NO'
  AND lookup_code   = CategoryBookDefaultEO.ALLOCATE_TO_FULLY_RSV_FLAG
  ),'No') AS RES_ALLOCATE_TO_FULLY_RETIRED_ ,
  DECODE(CategoryBookDefaultEO.EXCESS_ALLOCATION_OPTION,'DISTRIBUTE','Distribute excess','REDUCE','Reduce excess',NULL) AS RES_DISTRIBUTE_EXCESS_OR_REDUC ,
  (SELECT ASSET_NUMBER
	FROM FA_ADDITIONS_VL
	WHERE SERIAL_NUMBER = to_Char(CategoryBookDefaultEO.GROUP_ASSET_ID)
  ) AS RES_GROUP_ASSET_NUMBER ,
  CategoryBookDefaultEO.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY ,
  CategoryBookDefaultEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE ,
  CategoryBookDefaultEO.CREATED_BY RSC_CREATED_BY ,
  CategoryBookDefaultEO.CREATION_DATE RSC_CREATION_DATE ,
  PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID ,
  NULL RSC_CHART_OF_ACCOUNTS_ID ,
  NULL RSC_BUSINESS_UNIT_ID ,
  NULL RSC_LEGAL_ENTITY_ID ,
  NULL RSC_ORGANIZATION_ID ,
  NULL RSC_BUSINESS_GROUP_ID ,
  NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_CATEGORY_BOOK_DEFAULTS CategoryBookDefaultEO
,FA_BOOK_CONTROLS BookControlPEO
,FA_CATEGORIES_B faCatsE0
,(select RSHIP.TARGET_LEDGER_ID
	, RSHIP.PRIMARY_LEDGER_ID 
	from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
WHERE CategoryBookDefaultEO.BOOK_TYPE_CODE = BookControlPEO.BOOK_TYPE_CODE
AND BookControlPEO.SET_OF_BOOKS_ID = PGL.TARGET_LEDGER_ID
AND CategoryBookDefaultEO.CATEGORY_ID = faCatsE0.CATEGORY_ID
ORDER BY RES_CATEGORY1