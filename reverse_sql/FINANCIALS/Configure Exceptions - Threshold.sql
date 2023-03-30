/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_EXCEPTION_VL
 
SELECT ExceptionE0.NAME RES_EXCEPTION
,MeasuresE0.NAME RES_BASE_MEASURE
,MeasuresE0.DESCRIPTION RES_DESCRIPTION
,DECODE(ExceptionE0.EXCEPTION_OPERATION,'!=','Does not equal'
	,'=','Equals' 
	,'>','Greater than' 
	,'>=','Greater than or equal to' 
	,'<','Less than' 
	,'<=','Less than or equal to' 
	) RES_OPERATION
,DECODE(ExceptionE0.THRESHOLD_TYPE,'1','Value','2','Measure') RES_THRESHOLD
,(CASE
	WHEN ExceptionE0.THRESHOLD_TYPE = '1' THEN
		ExceptionE0.THRESHOLD
	END) RES_VALUE
,(CASE
	WHEN ExceptionE0.THRESHOLD_TYPE = '2' THEN
		(SELECT NAME
			FROM MSC_MEASURES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND MEASURE_ID = ExceptionE0.THRESHOLD)
	END) RES_MEASURE
,ExceptionE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ExceptionE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ExceptionE0.CREATED_BY  RSC_CREATED_BY
,ExceptionE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_EXCEPTION_VL ExceptionE0
,MSC_MEASURES_TL MeasuresE0
WHERE ExceptionE0.BASIS_VALUE = MeasuresE0.MEASURE_ID
AND MeasuresE0.LANGUAGE = USERENV('LANG')
ORDER BY ExceptionE0.NAME
,MeasuresE0.NAME