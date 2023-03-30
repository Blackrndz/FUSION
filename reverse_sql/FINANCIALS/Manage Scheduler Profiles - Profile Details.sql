/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HXT_SETUP_PROFILES_VL

WITH DAY_ATTR AS (SELECT setsE0.SCHED_PROFILE_ID
    ,valsE0.VAL_INDEX
    ,valsE0.VALUE
    FROM HTS_LABOR_DEMAND_PRFL_DEFSETS setsE0
    ,HTS_LABOR_DEMAND_PRFL_DEFS defsE0
    ,HTS_LABOR_DEMAND_PRFL_VALS valsE0
    WHERE setsE0.LBR_DMD_PRFL_SET_ID = defsE0.LBR_DMD_PRFL_SET_ID
    AND defsE0.LBR_DMD_PRFL_DEF_ID = valsE0.LBR_DMD_PRFL_DEF_ID)

SELECT profilesE0.NAME RES_PROFILE_NAME
,profilesE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(valsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE

--Scheduling Group
,(CASE
    WHEN valsE0.VALUE50 IS NOT NULL THEN
        'Group Manager'
    WHEN valsE0.VALUE55 IS NOT NULL THEN
        'Group Name'
    END) RES_SCHEDULING_GROUP_TYPE
,(CASE
    WHEN valsE0.VALUE50 IS NOT NULL THEN
		(SELECT LIST_NAME
			FROM PER_PERSON_NAMES_F
			WHERE NAME_TYPE = 'GLOBAL'
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
			AND PERSON_ID = valsE0.VALUE50)
    WHEN valsE0.VALUE55 IS NOT NULL THEN
		(SELECT GROUP_NAME
			FROM HWM_GRPS_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND GRP_ID = valsE0.VALUE55)
    END) RES_GROUP_MANAGERGROUP_NAME

--Resources Required
,(SELECT VALUE
    FROM DAY_ATTR
    WHERE VAL_INDEX = 0
    AND SCHED_PROFILE_ID = valsE0.SETUP_OPTION_VAL_ID
    ) RES_RESOURCES_REQUIRED_SUNDAY
,(SELECT VALUE
    FROM DAY_ATTR
    WHERE VAL_INDEX = 1
    AND SCHED_PROFILE_ID = valsE0.SETUP_OPTION_VAL_ID
    ) RES_RESOURCES_REQUIRED_MONDAY
,(SELECT VALUE
    FROM DAY_ATTR
    WHERE VAL_INDEX = 2
    AND SCHED_PROFILE_ID = valsE0.SETUP_OPTION_VAL_ID
    ) RES_RESOURCES_REQUIRED_TUESDAY
,(SELECT VALUE
    FROM DAY_ATTR
    WHERE VAL_INDEX = 3
    AND SCHED_PROFILE_ID = valsE0.SETUP_OPTION_VAL_ID
    ) RES_RESOURCES_REQUIRED_WEDNESD
,(SELECT VALUE
    FROM DAY_ATTR
    WHERE VAL_INDEX = 4
    AND SCHED_PROFILE_ID = valsE0.SETUP_OPTION_VAL_ID
    ) RES_RESOURCES_REQUIRED_THURSDA
,(SELECT VALUE
    FROM DAY_ATTR
    WHERE VAL_INDEX = 5
    AND SCHED_PROFILE_ID = valsE0.SETUP_OPTION_VAL_ID
    ) RES_RESOURCES_REQUIRED_FRIDAY
,(SELECT VALUE
    FROM DAY_ATTR
    WHERE VAL_INDEX = 6
    AND SCHED_PROFILE_ID = valsE0.SETUP_OPTION_VAL_ID
    ) RES_RESOURCES_REQUIRED_SATURDA

--Planned and Published Schedule Display
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_FIRST_DAY'
    AND LOOKUP_CODE = valsE0.VALUE53
    ) RES_FIRST_DAY_OF_THE_WEEK

--Display Labels
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_SHIFT_DISPLAY_LABEL'
    AND LOOKUP_CODE = valsE0.VALUE11
    ) RES_SHIFT_WITH_DEFINED_LIMITS
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_SHIFT_DISPLAY_LABEL'
    AND LOOKUP_CODE = valsE0.VALUE12
    ) RES_SHIFT_WITHOUT_DEFINED_LIMI

--Required Resource Thresholds
,DECODE(LOWER(TRIM(valsE0.VALUE14))
	,'#ffff7d','Default Color'

	,NULL,'Transparent'
	,'#b0e0e6','Powder Blue'
	,'#00fa9a','Medium Spring Green'
	,'#f5f5dc','Beige'
	,'#ffe4c4','Bisque'
	,'#ffdab9','Peach Puff'
	,'#ffc0cb','Pink'
	
	,'#ffffff','White'
	,'#add8e6','Light Blue'
	,'#00ff7f','Spring Green'
	,'#fafad2','Light Golden Rod Yellow'
	,'#ffe4b5','Moccasin'
	,'#f5deb3','Wheat'
	,'#ffb6c1','Light Pink'
	
	,'#f8f8ff','Ghost White'
	,'#87ceeb','Sky Blue'
	,'#3cb371','Medium Sea Green'
	,'#eee8aa','Pale Golden Rod'
	,'#ffa07a','Light Salmon'
	,'#f4a460','Sandy Brown'
	,'#db7093','Pale Violet Red'
	
	,'#dcdcdc','Gainsboro'
	,'#00bfff','Deep Sky Blue'
	,'#2e8b57','Sea Green'
	,'#ffff00','Yellow'
	,'#fa8072','Salmon'
	,'#ff6347','Tomato'
	,'#ff00ff','Magenta'
	
	,'#a9a9a9','Dark Gray'
	,'#4169e1','Royal Blue'
	,'#008000','Green'
	,'#ffa500','Orange'
	,'#cd5c5c','Indian Red'
	,'#ff0000','Red'
	,'#ff1493','Deep Pink'
	
	,'#808080','Gray'
	,'#0000ff','Blue'
	,'#6b8e23','Olive Drab'
	,'#ff8c00','Dark Orange'
	,'#a52a2a','Brown'
	,'#d2691e','Chocolate'
	,'#d02090','Violet Red'
	
	,'#000000','Black'
	,'#191970','Midnight Blue'
	,'#006400','Dark Green'
	,'#b8860b','Dark Golden Rod'
	,'#b22222','Fire Brick'
	,'#800000','Maroon'
	,'#8b008b','Dark Magenta'
	
	,valsE0.VALUE14
	) RES_OVER_COLOR
,DECODE(LOWER(TRIM(valsE0.VALUE15))
	,'#f28d82','Default Color'

	,NULL,'Transparent'
	,'#b0e0e6','Powder Blue'
	,'#00fa9a','Medium Spring Green'
	,'#f5f5dc','Beige'
	,'#ffe4c4','Bisque'
	,'#ffdab9','Peach Puff'
	,'#ffc0cb','Pink'
	
	,'#ffffff','White'
	,'#add8e6','Light Blue'
	,'#00ff7f','Spring Green'
	,'#fafad2','Light Golden Rod Yellow'
	,'#ffe4b5','Moccasin'
	,'#f5deb3','Wheat'
	,'#ffb6c1','Light Pink'
	
	,'#f8f8ff','Ghost White'
	,'#87ceeb','Sky Blue'
	,'#3cb371','Medium Sea Green'
	,'#eee8aa','Pale Golden Rod'
	,'#ffa07a','Light Salmon'
	,'#f4a460','Sandy Brown'
	,'#db7093','Pale Violet Red'
	
	,'#dcdcdc','Gainsboro'
	,'#00bfff','Deep Sky Blue'
	,'#2e8b57','Sea Green'
	,'#ffff00','Yellow'
	,'#fa8072','Salmon'
	,'#ff6347','Tomato'
	,'#ff00ff','Magenta'
	
	,'#a9a9a9','Dark Gray'
	,'#4169e1','Royal Blue'
	,'#008000','Green'
	,'#ffa500','Orange'
	,'#cd5c5c','Indian Red'
	,'#ff0000','Red'
	,'#ff1493','Deep Pink'
	
	,'#808080','Gray'
	,'#0000ff','Blue'
	,'#6b8e23','Olive Drab'
	,'#ff8c00','Dark Orange'
	,'#a52a2a','Brown'
	,'#d2691e','Chocolate'
	,'#d02090','Violet Red'
	
	,'#000000','Black'
	,'#191970','Midnight Blue'
	,'#006400','Dark Green'
	,'#b8860b','Dark Golden Rod'
	,'#b22222','Fire Brick'
	,'#800000','Maroon'
	,'#8b008b','Dark Magenta'
	
	,valsE0.VALUE15
	) RES_UNDER_COLOR
,DECODE(LOWER(TRIM(valsE0.VALUE16))
	,'#ccddab','Default Color'

	,NULL,'Transparent'
	,'#b0e0e6','Powder Blue'
	,'#00fa9a','Medium Spring Green'
	,'#f5f5dc','Beige'
	,'#ffe4c4','Bisque'
	,'#ffdab9','Peach Puff'
	,'#ffc0cb','Pink'
	
	,'#ffffff','White'
	,'#add8e6','Light Blue'
	,'#00ff7f','Spring Green'
	,'#fafad2','Light Golden Rod Yellow'
	,'#ffe4b5','Moccasin'
	,'#f5deb3','Wheat'
	,'#ffb6c1','Light Pink'
	
	,'#f8f8ff','Ghost White'
	,'#87ceeb','Sky Blue'
	,'#3cb371','Medium Sea Green'
	,'#eee8aa','Pale Golden Rod'
	,'#ffa07a','Light Salmon'
	,'#f4a460','Sandy Brown'
	,'#db7093','Pale Violet Red'
	
	,'#dcdcdc','Gainsboro'
	,'#00bfff','Deep Sky Blue'
	,'#2e8b57','Sea Green'
	,'#ffff00','Yellow'
	,'#fa8072','Salmon'
	,'#ff6347','Tomato'
	,'#ff00ff','Magenta'
	
	,'#a9a9a9','Dark Gray'
	,'#4169e1','Royal Blue'
	,'#008000','Green'
	,'#ffa500','Orange'
	,'#cd5c5c','Indian Red'
	,'#ff0000','Red'
	,'#ff1493','Deep Pink'
	
	,'#808080','Gray'
	,'#0000ff','Blue'
	,'#6b8e23','Olive Drab'
	,'#ff8c00','Dark Orange'
	,'#a52a2a','Brown'
	,'#d2691e','Chocolate'
	,'#d02090','Violet Red'
	
	,'#000000','Black'
	,'#191970','Midnight Blue'
	,'#006400','Dark Green'
	,'#b8860b','Dark Golden Rod'
	,'#b22222','Fire Brick'
	,'#800000','Maroon'
	,'#8b008b','Dark Magenta'
	
	,valsE0.VALUE16
	) RES_NORMAL_COLOR
,valsE0.VALUE51 RES_OVER_STAFFING_DIFFERENCE
,valsE0.VALUE52 RES_UNDER_STAFFING_DIFFERENCE

,profilesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,profilesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,profilesE0.CREATED_BY RSC_CREATED_BY
,profilesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,profilesE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM HXT_SETUP_PROFILES_VL profilesE0
,HXT_SETUP_OPTION_VALS valsE0
WHERE profilesE0.PRODUCT_AREA = 'HTS'
AND profilesE0.SETUP_PROFILE_ID = valsE0.SETUP_PROFILE_ID(+)
ORDER BY profilesE0.NAME