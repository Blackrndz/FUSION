/* ****************************************************************************
 * $Revision: 72463 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-08-02 16:39:09 +0700 (Fri, 02 Aug 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Actions%20-%20Action.sql $:
 * $Id: Manage Actions - Action.sql 72463 2019-08-02 09:39:09Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=PER_ACTION_REASONS_VL

SELECT actionReasonsE0.ACTION_REASON_CODE RES_ACTION_REASON_CODE
,actionReasonsE0.ACTION_REASON RES_ACTION_REASON
--,TO_CHAR(actionReasonsE0.START_DATE,'DD-Mon-YYYY') RES_REASON_START_DATE
--,TO_CHAR(actionReasonsE0.END_DATE,'DD-Mon-YYYY') RES_REASON_END_DATE
,actionReasonsE0.DESCRIPTION RES_DESCRIPTION
,actionReasonsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,actionReasonsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,actionReasonsE0.CREATED_BY  RSC_CREATED_BY
,actionReasonsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_ACTION_REASONS_VL actionReasonsE0
WHERE SYSDATE BETWEEN actionReasonsE0.START_DATE AND actionReasonsE0.END_DATE
ORDER BY actionReasonsE0.ACTION_REASON_CODE