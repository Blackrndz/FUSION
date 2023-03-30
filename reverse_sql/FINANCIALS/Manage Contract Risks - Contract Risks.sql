/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT contractRisksE0.NAME RES_NAME
,contractRisksE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(contractRisksE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(contractRisksE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,contractRisksE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,contractRisksE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,contractRisksE0.CREATED_BY  RSC_CREATED_BY
,contractRisksE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_RISK_EVENTS_VL contractRisksE0
ORDER BY contractRisksE0.NAME