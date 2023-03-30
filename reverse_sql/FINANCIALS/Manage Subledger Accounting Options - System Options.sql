/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Subledger%20Accounting%20Options%20-%20System%20Options.sql $:
 * $Id: Manage Subledger Accounting Options - System Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT GlLedgers.NAME AS RES_LEDGER
,SUBLEDGERAPPLICATIONPEO.APPLICATION_NAME AS RES_SUBLEDGER_APPLICATION
,LaunchOptionEO.PROCESSES                           AS RES_NUMBER_OF_CREATE_ACCOUNTIN
,LaunchOptionEO.PROCESSING_UNIT_SIZE                AS RES_PROCESSING_UNIT_SIZE
,DECODE(LaunchOptionEO.ERROR_LIMIT,NULL,'No','Yes') AS RES_STOP_AT_ERROR_LIMIT
,LaunchOptionEO.ERROR_LIMIT                         AS RES_ERROR_LIMIT
,LaunchOptionEO.GL_TRANS_PROCESSES                  AS RES_NUMBER_OF_GENERAL_LEDGER_T
,LaunchOptionEO.GL_TRANS_PROC_UNIT_SIZE             AS RES_TRANSFER_TO_GENERAL_LEDGER
,LaunchOptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LaunchOptionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LaunchOptionEO.CREATED_BY RSC_CREATED_BY
,LaunchOptionEO.CREATION_DATE RSC_CREATION_DATE
,LaunchOptionEO.LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from GL_LEDGERS GLLEDGERS
,XLA_SUBLEDGERS_TL SUBLEDGERAPPLICATIONPEO
,XLA_LAUNCH_OPTIONS LAUNCHOPTIONEO
where LAUNCHOPTIONEO.LEDGER_ID = GLLEDGERS.LEDGER_ID    
and LAUNCHOPTIONEO.APPLICATION_ID = SUBLEDGERAPPLICATIONPEO.APPLICATION_ID
and SUBLEDGERAPPLICATIONPEO.LANGUAGE         = USERENV('LANG')
AND SUBLEDGERAPPLICATIONPEO.APPLICATION_NAME != 'Subledger Accounting'
ORDER BY GlLedgers.NAME