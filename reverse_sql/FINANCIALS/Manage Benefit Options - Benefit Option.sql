/* ****************************************************************************
* $Revision: 78759 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-15 12:41:43 +0700 (Wed, 15 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Options%20-%20Benefit%20Option.sql $:
* $Id: Manage Benefit Options - Benefit Option.sql 78759 2022-06-15 05:41:43Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT optionsE0.NAME RES_OPTION_NAME

,optionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,optionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,optionsE0.CREATED_BY RSC_CREATED_BY
,optionsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,optionsE0.LEGISLATION_CODE RSC_COUNTRY_ID
FROM BEN_OPT_F optionsE0
WHERE SYSDATE BETWEEN optionsE0.EFFECTIVE_START_DATE AND optionsE0.EFFECTIVE_END_DATE
ORDER BY optionsE0.NAME