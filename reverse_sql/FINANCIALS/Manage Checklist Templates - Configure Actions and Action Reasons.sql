/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-28 $:
 * $HeadURL:  $:
 * $Id: Manage Pricing Bases - Pricing Basis.sql 54097 2016-03-30 09:27:56Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_CHECKLIST_ACTIONS

SELECT chklistsE0.NAME RES_CHECKLIST_NAME
,(SELECT ACTION_NAME
    FROM PER_ACTIONS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND ACTION_ID = configActionsE0.ACTION_ID
    ) RES_ACTION_NAME
,(SELECT ACTION_REASON
    FROM PER_ACTION_REASONS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND ACTION_REASON_ID = configActionsE0.ACTION_REASON_ID
    ) RES_REASON_NAME
,DECODE(configActionsE0.ENABLED_FLAG,'Y','Yes','No') RES_ACTIVE
,configActionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,configActionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,configActionsE0.CREATED_BY RSC_CREATED_BY
,configActionsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_CHECKLISTS_VL chklistsE0
,PER_CHECKLIST_ACTIONS configActionsE0
WHERE chklistsE0.CHECKLIST_ID = configActionsE0.CHECKLIST_ID
AND configActionsE0.ACTION_TYPE = 'ORA_ACTION_AND_REASON'
ORDER BY chklistsE0.NAME