/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

SELECT catsE0.TCAT_NAME RES_NAME
--,DECODE(catExpsE0.LEFT_PARENTHESIS_NUM,0,'',1,'(') RES_PARENTHESES
,DECODE(catExpsE0.LEFT_PARENTHESIS_NUM,0,''
	,1,'('
	,2,'(('
	,3,'((('
	,4,'(((('
	,5,'((((('
	,6,'(((((('
	,7,'((((((('
	,8,'(((((((('
	,9,'((((((((('
	,10,'(((((((((('
	) RES_PARENTHESES
,(SELECT DISPLAY_NAME
    FROM HWM_TM_ATRB_FLDS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TM_ATRB_FLD_ID = catExpsE0.TIME_ATRB_FLD_ID
    ) RES_TIME_ATTRIBUTE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_TCAT_VALUETYPES'
    AND LOOKUP_CODE = catExpsE0.VALUE_TYPE
    ) RES_VALUE_TYPE
,catExpsE0.DISPLAY_VALUE RES_VALUE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HWM_TCAT_OPERATOR'
    AND LOOKUP_CODE = catExpsE0.OPERATOR
    ) RES_OPERATOR
--,DECODE(catExpsE0.RIGHT_PARENTHESIS_NUM,0,'',1,')') RIGHT_PARENTHESIS
,catExpsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,catExpsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,catExpsE0.CREATED_BY RSC_CREATED_BY
,catExpsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_TCATS_VL catsE0
,HWM_TCAT_EXPR_RESULTS_VL catExpsE0
WHERE catsE0.TCAT_ID = catExpsE0.TCAT_ID
AND catExpsE0.DISPLAY_SEQUENCE > 0
ORDER BY catsE0.TCAT_NAME
,catExpsE0.DISPLAY_SEQUENCE