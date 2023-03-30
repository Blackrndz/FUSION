/* ****************************************************************************
 * $Revision: 73701 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-03-05 12:34:33 +0700 (Thu, 05 Mar 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Remittance%20Bank%20Account.sql $:
 * $Id: Manage Receipt Classes and Methods - Remittance Bank Account.sql 73701 2020-03-05 05:34:33Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT TO_CHAR(laddersE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT SET_NAME
    FROM FND_SETID_SETS
    WHERE LANGUAGE = USERENV('LANG')
    AND SET_ID = laddersE0.GRADE_SET_ID
    ) RES_GRADE_SET
,laddersE0.NAME RES_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'GRADE_TYPE'
    AND LOOKUP_CODE = laddersE0.GRADE_TYPE
    ) RES_GRADE_TYPE
,DECODE(laddersE0.ACTIVE_STATUS,'A','Active','I','Inactive') RES_STATUS
,(SELECT ACTION_REASON
    FROM PER_ACTION_OCCURRENCES actOccE0
    ,PER_ACTION_REASONS_TL ActReasonsE0
    WHERE ActReasonsE0.LANGUAGE = USERENV('LANG')
    AND actOccE0.ACTION_REASON_ID = ActReasonsE0.ACTION_REASON_ID
    AND actOccE0.ACTION_OCCURRENCE_ID = laddersE0.ACTION_OCCURRENCE_ID
    ) RES_ACTION_REASON
,laddersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,laddersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,laddersE0.CREATED_BY RSC_CREATED_BY
,laddersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_GRADE_LADDERS_F_VL laddersE0
ORDER BY laddersE0.NAME
,laddersE0.EFFECTIVE_START_DATE