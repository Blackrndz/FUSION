/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payroll%20Flow%20Security%20Profile%20-%20Payroll%20Flows.sql $:
 * $Id: Manage Payroll Flow Security Profile - Payroll Flows.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT payFLOWSECEO.NAME RES_NAME
,(SELECT FLOW_NAME FROM PAY_FLOWS_VL WHERE FLOW_ID = payFLWSECPAYEO.FLOW_ID) RES_PAYROLL_FLOW

,payFLWSECPAYEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payFLWSECPAYEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payFLWSECPAYEO.CREATED_BY RSC_CREATED_BY
,payFLWSECPAYEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_FLW_SECURITY_PROFILES  payFLOWSECEO
,PAY_FLW_SECURITY_PROFILE_PAYS payFLWSECPAYEO
WHERE payFLOWSECEO.FLW_SECURITY_PROFILE_ID = payFLWSECPAYEO.FLW_SECURITY_PROFILE_ID