/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Statement%20Cycles%20-%20Manage%20Statement%20Cycles.sql $:
 * $Id: Manage Statement Cycles - Manage Statement Cycles.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select ARSTATEMENTCYCLES.name RES_NAME
,ARLOOKUPEO.MEANING RES_INTERVAL
,DECODE(ARSTATEMENTCYCLES.STATUS,'A','Yes','No') RES_ACTIVE
,ARSTATEMENTCYCLES.DESCRIPTION RES_DESCRIPTION
,ARSTATEMENTCYCLES.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ARSTATEMENTCYCLES.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ARSTATEMENTCYCLES.CREATED_BY  RSC_CREATED_BY
,ARSTATEMENTCYCLES.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from AR_STATEMENT_CYCLES ARSTATEMENTCYCLES 
,AR_LOOKUPS ARLOOKUPEO
where ARLOOKUPEO.LOOKUP_TYPE = 'INTERVAL_NAME'
and ARLOOKUPEO.LOOKUP_CODE   = ARSTATEMENTCYCLES.interval
ORDER BY ArStatementCycles.NAME