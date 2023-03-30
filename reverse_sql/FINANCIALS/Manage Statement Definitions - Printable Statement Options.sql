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

SELECT statementsE0.NAME RES_STATEMENT_DEFINITION_NAME
,DECODE(statementsE0.HIDE_PDF_ITEM_DETAILS_FLAG,'N','Yes','No') RES_INCLUDE_CATEGORY_LINE_ITEM
,DECODE(statementsE0.PDF_LOCAL_CURR_FLAG,'Y','Yes','No') RES_GENERATE_PRINTABLE_STATEME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_CMP_TCS_PDF_STMT_ACCESS'
    AND LOOKUP_CODE = statementsE0.PDF_LOCAL_CURR_AVLBL
    ) RES_STATEMENT_ACCESS_GENERATE_
,DECODE(statementsE0.PDF_OTHER_CURR_FLAG,'Y','Yes','No') RES_GENERATE_PRINTABLE_STATE_0
,(SELECT NAME
    FROM FND_CURRENCIES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND CURRENCY_CODE = statementsE0.PDF_OTHER_CURR_CODE
    ) RES_CURRENCY
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_CMP_TCS_PDF_STMT_ACCESS'
    AND LOOKUP_CODE = statementsE0.PDF_OTHER_CURR_AVLBL
    ) RES_STATEMENT_ACCESS_GENERAT_1
,statementsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,statementsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,statementsE0.CREATED_BY RSC_CREATED_BY
,statementsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_TCS_STMT_VL statementsE0
ORDER BY statementsE0.NAME