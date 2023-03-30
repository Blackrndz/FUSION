/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Scheduling%20Rules%20-%20Revenue%20Scheduling%20Rules.sql $:
 * $Id: Manage Revenue Scheduling Rules - Revenue Scheduling Rules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select (SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	where SET_ID = RARULES.SET_ID
	)  RES_SET
,RARULES.name RES_NAME
,RARULES.DESCRIPTION RES_DESCRIPTION
,DECODE(RARULES.STATUS,'A','Yes','No') RES_ACTIVE
,(select ARLOOKUPPEO.MEANING
FROM AR_LOOKUPS ArLookupPEO 
where ARLOOKUPPEO.LOOKUP_TYPE    = 'RULE_TYPE'
and ARLOOKUPPEO.LOOKUP_CODE = RARULES.type ) RES_TYPE
,RARULES.OCCURRENCES RES_NUMBER_OF_PERIODS
,DECODE(RARULES.DEFERRED_REVENUE_FLAG,'Y','Yes','No') RES_DEFERRED_REVENUE
,RARULES.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,RARULES.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,RARULES.CREATED_BY  RSC_CREATED_BY
  ,RARULES.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from RA_RULES RARULES
where RARULES.type not in('I')
order by 1,2