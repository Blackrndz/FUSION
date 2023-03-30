/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Distribution%20Sets%20-%20Distribution%20Lines.sql $:
 * $Id: Manage Receivables Distribution Sets - Distribution Lines.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- FIELD_TO_APPLY_FUNCTION=RES_ACCOUNT/GET_CODE_COMBINATION

select BUSINESSUNITPEO.BU_NAME RES_BUSINESS_UNIT
,ARDISTRIBUTIONSETSALL.DISTRIBUTION_SET_NAME RES_NAME
,ArDistributionSetLinesAll.PERCENT_DISTRIBUTION  RES_PERCENTAGE
,ArDistributionSetLinesAll.DIST_CODE_COMBINATION_ID RES_ACCOUNT
,ARDISTRIBUTIONSETLINESALL.DESCRIPTION  RES_LINE_DESCRIPTION
,ArDistributionSetLinesAll.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ArDistributionSetLinesAll.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ArDistributionSetLinesAll.CREATED_BY  RSC_CREATED_BY
,ArDistributionSetLinesAll.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,ArDistributionSetLinesAll.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from AR_DISTRIBUTION_SETS_ALL ArDistributionSetsAll
,AR_DISTRIBUTION_SET_LINES_ALL ArDistributionSetLinesAll
,GL_LEDGERS GLLEDGERS
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
where ARDISTRIBUTIONSETLINESALL.SET_OF_BOOKS_ID   = GLLEDGERS.LEDGER_ID
and ARDISTRIBUTIONSETSALL.ORG_ID   = BUSINESSUNITPEO.BU_ID
and  ARDISTRIBUTIONSETSALL.DISTRIBUTION_SET_ID   =   ARDISTRIBUTIONSETLINESALL.DISTRIBUTION_SET_ID
order by BUSINESSUNITPEO.BU_NAME,ARDISTRIBUTIONSETSALL.DISTRIBUTION_SET_NAME