/* ****************************************************************************
* $Revision: 72658 $:
* $Author: tanawat.wongjan $:
* $Date: 2019-10-01 15:00:45 +0700 (Tue, 01 Oct 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20SCM%20Common%20Value%20Sets%20-%20Manage%20SCM%20Common%20Value%20Sets.sql $:
* $Id: Manage SCM Common Value Sets - Manage SCM Common Value Sets.sql 55804 2016-06-09 04:17:45Z wuttipong.thongvises
$:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_TCS_STMT_VL
-- REPLACE_HTML_KEYWORD = RES_WELCOME_MESSAGE

SELECT statementsE0.NAME RES_STATEMENT_DEFINITION_NAME
,TO_CHAR(periodsE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(periodsE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,periodsE0.DISPLAY_PERIOD RES_DISPLAY_NAME
,TO_CHAR(periodsE0.AVAILABILITY_DATE,'DD-Mon-YYYY') RES_DATE_AVAILABLE_TO_WORKERS
,TO_CHAR(periodsE0.XCHG_RATE_DATE,'DD-Mon-YYYY') RES_CURRENCY_CONVERSION_DATE
--,DECODE(periodsE0.HIDE_WELCOME_FLAG,'Y','Yes','No') PDF_LOCAL_CURR_FLAG
,REPLACE(REPLACE(REPLACE(periodsE0.WELCOME_TEXT,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_WELCOME_MESSAGE
,'' RES_STATEMENTS_GENERATED
,periodsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,periodsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,periodsE0.CREATED_BY RSC_CREATED_BY
,periodsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_TCS_STMT_VL statementsE0
,CMP_TCS_STMT_PERD_VL periodsE0
WHERE statementsE0.STMT_ID = periodsE0.STMT_ID
ORDER BY statementsE0.NAME
,periodsE0.START_DATE DESC