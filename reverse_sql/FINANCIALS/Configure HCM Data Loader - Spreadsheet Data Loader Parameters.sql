/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HRC_DL_ALL_PARAMETERS
 
SELECT (SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'ORA_HRC_DL_PARAM_CATEGORY'
	AND LOOKUP_CODE = parametersE0.PARAM_CATEGORY
	AND LANGUAGE = USERENV('LANG')
	) RES_CATEGORY
,paramNamesE0.MEANING RES_PARAMETER
,(CASE
	WHEN parametersE0.VALUE_LOOKUP_TYPE IS NOT NULL THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LOOKUP_TYPE = parametersE0.VALUE_LOOKUP_TYPE
			AND LOOKUP_CODE = parametersE0.HSDL_DEFAULT_VALUE
			AND LANGUAGE = USERENV('LANG')
			AND VIEW_APPLICATION_ID = 3
			)
	ELSE
		parametersE0.HSDL_DEFAULT_VALUE
	END) RES_DEFAULT
,(CASE
	WHEN parametersE0.VALUE_LOOKUP_TYPE IS NOT NULL THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LOOKUP_TYPE = parametersE0.VALUE_LOOKUP_TYPE
			AND LOOKUP_CODE = overidesE0.OVERRIDE_VALUE
			AND LANGUAGE = USERENV('LANG')
			AND VIEW_APPLICATION_ID = 3
			)
	ELSE
		overidesE0.OVERRIDE_VALUE
	END) RES_OVERRIDE
,paramNamesE0.DESCRIPTION RES_DESCRIPTION
,parametersE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,parametersE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,parametersE0.CREATED_BY  RSC_CREATED_BY
,parametersE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRC_DL_ALL_PARAMETERS parametersE0
,(SELECT PARAMETER_ID
	,OVERRIDE_VALUE
	FROM HRC_DL_PARAMETER_OVERRIDES 
	WHERE OVERRIDE_LEVEL = 'HSDL'
	) overidesE0
,(SELECT MEANING
	,LOOKUP_CODE
	,DESCRIPTION
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'HRC_DL_PARAMETERS'
	AND LANGUAGE = USERENV('LANG')
	) paramNamesE0
WHERE parametersE0.PARAMETER_ID = overidesE0.PARAMETER_ID(+)
AND parametersE0.PARAM_NAME = paramNamesE0.LOOKUP_CODE
AND parametersE0.BUS_OBJ_TOP_DISCRIMINATOR IS NULL
AND parametersE0.HSDL_ENABLED = 'Y'
ORDER BY 1,2