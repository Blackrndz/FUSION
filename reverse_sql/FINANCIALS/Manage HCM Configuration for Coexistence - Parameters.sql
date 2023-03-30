/* ****************************************************************************
 * $Revision: 68503 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-30 10:29:32 +0700 (Thu, 30 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Action%20Controls%20-%20Actions.sql $:
 * $Id: Manage Action Controls - Actions.sql 68503 2018-08-30 03:29:32Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HRC_LOADER_PARAMETERS

SELECT (SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRC_LOADER_PARAMETERS'
    AND LOOKUP_CODE = paramsE0.PARAM_NAME
    ) RES_PARAMETER_NAME 
,paramsE0.PARAM_VALUE RES_PARAMETER_VALUE
,paramsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,paramsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,paramsE0.CREATED_BY  RSC_CREATED_BY
,paramsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRC_LOADER_PARAMETERS paramsE0