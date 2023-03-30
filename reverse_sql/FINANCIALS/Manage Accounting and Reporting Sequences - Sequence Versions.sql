/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20and%20Reporting%20Sequences%20-%20Sequence%20Versions.sql $:
 * $Id: Manage Accounting and Reporting Sequences - Sequence Versions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT HEADER_NAME AS RES_SEQUENCE_NAME
,VERSION_NAME AS RES_NAME
,(SELECT MEANING 
  FROM FND_LOOKUPS 
  WHERE LOOKUP_TYPE = 'FUN_SEQ_STATUS_FILTER' 
  AND LOOKUP_CODE = USE_STATUS_CODE) AS RES_STATUS
,TO_CHAR(START_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_START_DATE
,TO_CHAR(END_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_END_DATE
,INITIAL_VALUE AS RES_INITIAL_NUMBER
,CURRENT_VALUE AS RES_LAST_NUMBER_USED
,LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CREATED_BY  RSC_CREATED_BY
,CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUN_SEQ_VERSIONS FunSeqVersions
ORDER BY RES_SEQUENCE_NAME