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

WITH TIME_ATTR AS (SELECT 1 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE34 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 2 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE35 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 3 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE36 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 4 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE37 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 5 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE38 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 6 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE39 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 7 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE40 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 8 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE41 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 9 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE42 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 10 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE43 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 11 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE44 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 12 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE45 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 13 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE46 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 14 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE47 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 15 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE48 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 16 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE49 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 17 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE50 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 18 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE51 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 19 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE52 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 20 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE53 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 21 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE54 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 22 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE55 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 23 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE56 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 24 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE57 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 25 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE58 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 26 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE59 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 27 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE60 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 28 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE61 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 29 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE62 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 30 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE63 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 31 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE64 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 32 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE65 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 33 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE66 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 34 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE67 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
    
    UNION
    
    SELECT 35 SEQ
    ,SETUP_PROFILE_ID
    ,VALUE68 ATTR_ID
    FROM HXT_SETUP_OPTION_VALS
)


SELECT tDevicesE0.NAME RES_PROFILE_NAME
,(SELECT DISPLAY_NAME
    FROM HWM_TM_ATRB_FLDS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TM_ATRB_FLD_ID = TIME_ATTR.ATTR_ID
    ) RES_TIME_ATTRIBUTE
,tDevicesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,tDevicesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,tDevicesE0.CREATED_BY RSC_CREATED_BY
,tDevicesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,tDevicesE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HXT_SETUP_PROFILES_VL tDevicesE0
,(SELECT *
    FROM TIME_ATTR
    WHERE ATTR_ID IS NOT NULL) TIME_ATTR
WHERE tDevicesE0.PRODUCT_AREA = 'TIME_DEVICE'
AND tDevicesE0.SETUP_PROFILE_ID = TIME_ATTR.SETUP_PROFILE_ID
ORDER BY tDevicesE0.PRECEDENCE
,TIME_ATTR.SEQ DESC