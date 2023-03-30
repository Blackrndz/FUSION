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
,ExceptionE0.DISPLAY_NAME RES_DISPLAY_NAME
,'Measure' RES_BASIS
,(SELECT NAME
	FROM MSC_MEASURES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND MEASURE_ID = ExceptionE0.BASIS_VALUE
	) RES_BASE_MEASURE
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
ORDER BY ExceptionE0.NAME