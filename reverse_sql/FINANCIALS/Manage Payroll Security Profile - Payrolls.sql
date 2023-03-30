/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payroll%20Security%20Profile%20-%20Payrolls.sql $:
 * $Id: Manage Payroll Security Profile - Payrolls.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT payPAYSECEO.NAME RES_NAME
,(SELECT PAYROLL_NAME FROM PAY_ALL_PAYROLLS_F  WHERE PAYROLL_ID = payPAYSECPAYEO.PAYROLL_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_PAYROLL_NAME

,payPAYSECPAYEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payPAYSECPAYEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payPAYSECPAYEO.CREATED_BY RSC_CREATED_BY
,payPAYSECPAYEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_PAY_SECURITY_PROFILES  payPAYSECEO
,PAY_PAY_SECURITY_PROFILE_PAYS payPAYSECPAYEO
WHERE payPAYSECEO.PAY_SECURITY_PROFILE_ID = payPAYSECPAYEO.PAY_SECURITY_PROFILE_ID