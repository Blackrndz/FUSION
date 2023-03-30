 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT LotExpirationActionEO.ACTION_CODE RES_NAME
,LotExpirationActionEO.DESCRIPTION RES_DESCRIPTION
,DECODE(LotExpirationActionEO.DISABLE_FLAG,'N','Yes','No') RES_ACTIVE
,LotExpirationActionEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LotExpirationActionEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LotExpirationActionEO.CREATED_BY  RSC_CREATED_BY
,LotExpirationActionEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ACTIONS_VL LotExpirationActionEO
ORDER BY LotExpirationActionEO.ACTION_CODE