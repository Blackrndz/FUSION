/* ****************************************************************************
 * $Revision: 60967 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-08 14:29:52 +0700 (Wed, 08 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Enterprise%20HCM%20Information%20-%20Enterprise.sql $:
 * $Id: Manage Enterprise HCM Information - Enterprise.sql 60967 2017-02-08 07:29:52Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HTS_CUSTOM_SHIFT_TYPES_VL

SELECT shiftsE0.SHIFT_NAME RES_NAME
,shiftDtlsE0.SHIFT_CODE RES_CODE
,shiftsE0.SHORT_TXT RES_SHORT_CODE
,shiftDtlsE0.SHIFT_SHORT_NAME RES_SHORT_NAME
,DECODE(LOWER(TRIM(shiftDtlsE0.SHIFT_COLOUR))
	,NULL,'Transparent'
	,'b0e0e6','Powder Blue'
	,'00fa9a','Medium Spring Green'
	,'f5f5dc','Beige'
	,'ffe4c4','Bisque'
	,'ffdab9','Peach Puff'
	,'ffc0cb','Pink'
	
	,'ffffff','White'
	,'add8e6','Light Blue'
	,'00ff7f','Spring Green'
	,'fafad2','Light Golden Rod Yellow'
	,'ffe4b5','Moccasin'
	,'f5deb3','Wheat'
	,'ffb6c1','Light Pink'
	
	,'f8f8ff','Ghost White'
	,'87ceeb','Sky Blue'
	,'3cb371','Medium Sea Green'
	,'eee8aa','Pale Golden Rod'
	,'ffa07a','Light Salmon'
	,'f4a460','Sandy Brown'
	,'db7093','Pale Violet Red'
	
	,'dcdcdc','Gainsboro'
	,'00bfff','Deep Sky Blue'
	,'2e8b57','Sea Green'
	,'ffff00','Yellow'
	,'fa8072','Salmon'
	,'ff6347','Tomato'
	,'ff00ff','Magenta'
	
	,'a9a9a9','Dark Gray'
	,'4169e1','Royal Blue'
	,'008000','Green'
	,'ffa500','Orange'
	,'cd5c5c','Indian Red'
	,'ff0000','Red'
	,'ff1493','Deep Pink'
	
	,'808080','Gray'
	,'0000ff','Blue'
	,'6b8e23','Olive Drab'
	,'ff8c00','Dark Orange'
	,'a52a2a','Brown'
	,'d2691e','Chocolate'
	,'d02090','Violet Red'
	
	,'000000','Black'
	,'191970','Midnight Blue'
	,'006400','Dark Green'
	,'b8860b','Dark Golden Rod'
	,'b22222','Fire Brick'
	,'800000','Maroon'
	,'8b008b','Dark Magenta'
	
	,shiftDtlsE0.SHIFT_COLOUR
	) RES_COLOR
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ZMM_SR_SHIFT_TYPE'
    AND LOOKUP_CODE = shiftsE0.SHIFT_TYPE_CODE
    ) RES_TYPE
,(CASE
    WHEN shiftsE0.SHIFT_TYPE_CODE = 'TIME' THEN
        TO_CHAR(TIMESTAMP '1970-01-01 00:00:00.000' + NUMTODSINTERVAL( shiftsE0.START_TIME_MS_NUM / 1000, 'SECOND' ),'HH:MI AM')
    END) RES_START_TIME
,(CASE
    WHEN shiftsE0.SHIFT_TYPE_CODE = 'TIME' THEN
        TO_CHAR(TIMESTAMP '1970-01-01 00:00:00.000' + NUMTODSINTERVAL( shiftsE0.END_TIME_MS_NUM / 1000, 'SECOND' ),'HH:MI AM')
    END) RES_END_TIME

,(CASE
    WHEN shiftsE0.SHIFT_TYPE_CODE = 'ELAPSED' THEN
        --TO_CHAR(TIMESTAMP '1970-01-01 00:00:00.000' + NUMTODSINTERVAL( shiftsE0.DURATION_MS_NUM / 1000, 'SECOND' ),'HH:MI AM')
        shiftsE0.DURATION_MS_NUM/1000/60/60
    END) RES_DURATION
    

,NULL RES_START_DATE

,(shiftDtlsE0.TIME_NOT_WORKED/1000/60) RES_TIME_NOT_WORKED

--Grace Period
,(shiftDtlsE0.TOLERANCE/1000/60) RES_GRACE_PERIOD_MINUTES

--Start Early Period
,shiftDtlsE0.START_EARLY_GRACE/1000/60 RES_START_EARLY_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftDtlsE0.START_EARLY_VIOLATION
    ) RES_START_EARLY_PERIOD_VIOLATI

--Start Late Period
,(shiftDtlsE0.START_LATE_GRACE/1000/60) RES_START_LATE_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftDtlsE0.START_LATE_VIOLATION
    ) RES_START_LATE_PERIOD_VIOLATIO

--End Early Period
,(shiftDtlsE0.END_EARLY_GRACE/1000/60) RES_END_EARLY_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftDtlsE0.END_EARLY_VIOLATION
    ) RES_END_EARLY_PERIOD_VIOLATION


--End Late Period
,(shiftDtlsE0.END_LATE_GRACE/1000/60) RES_END_LATE_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftDtlsE0.END_LATE_VIOLATION
    ) RES_END_LATE_PERIOD_VIOLATION_

,shiftDtlsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,shiftDtlsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,shiftDtlsE0.CREATED_BY  RSC_CREATED_BY
,shiftDtlsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,shiftDtlsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM ZMM_SR_SHIFTS_VL shiftsE0
,HTS_SHIFT_TYPES_DETAILS shiftDtlsE0
WHERE shiftsE0.SHIFT_ID = shiftDtlsE0.SHIFT_TYPE_ID

UNION

SELECT shiftsE0.SHIFT_NAME RES_NAME
,shiftsE0.SHIFT_CODE RES_CODE
,shiftsE0.SHORT_TXT RES_SHORT_CODE
,shiftsE0.SHIFT_SHORT_NAME RES_SHORT_NAME
,DECODE(LOWER(TRIM(shiftsE0.SHIFT_COLOUR))
	,NULL,'Transparent'
	,'b0e0e6','Powder Blue'
	,'00fa9a','Medium Spring Green'
	,'f5f5dc','Beige'
	,'ffe4c4','Bisque'
	,'ffdab9','Peach Puff'
	,'ffc0cb','Pink'
	
	,'ffffff','White'
	,'add8e6','Light Blue'
	,'00ff7f','Spring Green'
	,'fafad2','Light Golden Rod Yellow'
	,'ffe4b5','Moccasin'
	,'f5deb3','Wheat'
	,'ffb6c1','Light Pink'
	
	,'f8f8ff','Ghost White'
	,'87ceeb','Sky Blue'
	,'3cb371','Medium Sea Green'
	,'eee8aa','Pale Golden Rod'
	,'ffa07a','Light Salmon'
	,'f4a460','Sandy Brown'
	,'db7093','Pale Violet Red'
	
	,'dcdcdc','Gainsboro'
	,'00bfff','Deep Sky Blue'
	,'2e8b57','Sea Green'
	,'ffff00','Yellow'
	,'fa8072','Salmon'
	,'ff6347','Tomato'
	,'ff00ff','Magenta'
	
	,'a9a9a9','Dark Gray'
	,'4169e1','Royal Blue'
	,'008000','Green'
	,'ffa500','Orange'
	,'cd5c5c','Indian Red'
	,'ff0000','Red'
	,'ff1493','Deep Pink'
	
	,'808080','Gray'
	,'0000ff','Blue'
	,'6b8e23','Olive Drab'
	,'ff8c00','Dark Orange'
	,'a52a2a','Brown'
	,'d2691e','Chocolate'
	,'d02090','Violet Red'
	
	,'000000','Black'
	,'191970','Midnight Blue'
	,'006400','Dark Green'
	,'b8860b','Dark Golden Rod'
	,'b22222','Fire Brick'
	,'800000','Maroon'
	,'8b008b','Dark Magenta'
	
	,shiftsE0.SHIFT_COLOUR
	) RES_COLOR
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ZMM_SR_SHIFT_TYPE'
    AND LOOKUP_CODE = shiftsE0.SHIFT_TYPE_CODE
    ) RES_TYPE
,(CASE
    WHEN shiftsE0.SHIFT_TYPE_CODE = 'TIME' THEN
        TO_CHAR(TIMESTAMP '1970-01-01 00:00:00.000' + NUMTODSINTERVAL( shiftsE0.START_TIME_MS_NUM / 1000, 'SECOND' ),'HH:MI AM')
    END) RES_START_TIME
,(CASE
    WHEN shiftsE0.SHIFT_TYPE_CODE = 'TIME' THEN
        TO_CHAR(TIMESTAMP '1970-01-01 00:00:00.000' + NUMTODSINTERVAL( shiftsE0.END_TIME_MS_NUM / 1000, 'SECOND' ),'HH:MI AM')
    END) RES_END_TIME

,(CASE
    WHEN shiftsE0.SHIFT_TYPE_CODE = 'ELAPSED' THEN
        --TO_CHAR(TIMESTAMP '1970-01-01 00:00:00.000' + NUMTODSINTERVAL( shiftsE0.DURATION_MS_NUM / 1000, 'SECOND' ),'HH:MI AM')
        shiftsE0.DURATION_MS_NUM/1000/60/60
    END) RES_DURATION
    
,(CASE
    WHEN shiftsE0.SHIFT_TYPE_CODE = 'TIME' THEN
        (SELECT MEANING
            FROM FND_LOOKUP_VALUES
            WHERE LANGUAGE = USERENV('LANG')
            AND LOOKUP_TYPE = 'ORA_HTS_SHIFTS_DAY_INDICATOR'
            AND LOOKUP_CODE = shiftsE0.DAY_INDICATOR)
    END) RES_START_DATE

,(shiftsE0.TIME_NOT_WORKED/1000/60) RES_TIME_NOT_WORKED

--Grace Period
,(shiftsE0.TOLERANCE/1000/60) RES_GRACE_PERIOD_MINUTES

--Start Early Period
,(shiftsE0.START_EARLY_GRACE/1000/60) RES_START_EARLY_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftsE0.START_EARLY_VIOLATION
    ) RES_START_EARLY_PERIOD_VIOLATI

--Start Late Period
,(shiftsE0.START_LATE_GRACE/1000/60) RES_START_LATE_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftsE0.START_LATE_VIOLATION
    ) RES_START_LATE_PERIOD_VIOLATIO

--End Early Period
,(shiftsE0.END_EARLY_GRACE/1000/60) RES_END_EARLY_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftsE0.END_EARLY_VIOLATION
    ) RES_END_EARLY_PERIOD_VIOLATION

--End Late Period
,(shiftsE0.END_LATE_GRACE/1000/60) RES_END_LATE_PERIOD_MINUTES
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_RT_MSG_SEVERITY'
    AND LOOKUP_CODE = shiftsE0.END_LATE_VIOLATION
    ) RES_END_LATE_PERIOD_VIOLATION_

,shiftsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,shiftsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,shiftsE0.CREATED_BY  RSC_CREATED_BY
,shiftsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,shiftsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HTS_CUSTOM_SHIFT_TYPES_VL shiftsE0
ORDER BY 1