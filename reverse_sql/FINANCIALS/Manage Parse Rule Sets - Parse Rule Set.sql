/* ****************************************************************************
 * $Revision: 73658 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-02-28 13:42:07 +0700 (Fri, 28 Feb 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Absence%20Categories%20-%20Absence%20Category.sql $:
 * $Id: Manage Absence Categories - Absence Category.sql 73658 2020-02-28 06:42:07Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT cePARSINGRULESETE0.PARSING_RULE_SET_NAME RES_NAME
,cePARSINGRULESETE0.DESCRIPTION RES_DESCRIPTION
,DECODE(cePARSINGRULESETE0.ACTIVE_FLAG,'Y','Yes','No') RES_ACTIVE

,cePARSINGRULESETE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cePARSINGRULESETE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cePARSINGRULESETE0.CREATED_BY RSC_CREATED_BY
,cePARSINGRULESETE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_PARSING_RULE_SETS cePARSINGRULESETE0
ORDER BY cePARSINGRULESETE0.PARSING_RULE_SET_NAME