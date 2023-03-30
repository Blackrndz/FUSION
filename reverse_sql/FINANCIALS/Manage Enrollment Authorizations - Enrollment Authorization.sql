/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


-- REPLACE_HTML_KEYWORD = RES_AUTHORIZATION_TEXT

SELECT TO_CHAR(enrollAutSE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(enrollAutSE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,enrollAutSE0.DESCRIPTION RES_DESCRIPTION
,(SELECT NAME
	FROM BEN_PGM_F
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND PGM_ID = enrollAutSE0.PGM_ID
	) RES_PROGRAM_NAME
,(SELECT NAME
	FROM BEN_PL_F
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND PL_ID = enrollAutSE0.PL_ID
	) RES_PLAN_NAME 
,REPLACE(REPLACE(REPLACE(enrollAutSE0.DISCLAIMER_TEXT,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_AUTHORIZATION_TEXT
,enrollAutSE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,enrollAutSE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,enrollAutSE0.CREATED_BY  RSC_CREATED_BY
,enrollAutSE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,enrollAutSE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_LEGAL_DISCLAIMER enrollAutSE0
ORDER BY enrollAutSE0.DESCRIPTION