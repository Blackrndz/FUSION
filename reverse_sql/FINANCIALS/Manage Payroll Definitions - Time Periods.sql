/* ****************************************************************************
* $Revision: 55345 $:
* $Author: wuttipong.thongvises $:
* $Date: 2016-05-23 12:42:33 +0700 (Mon, 23 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT payALLPREO.PAYROLL_NAME RES_NAME
,payTIMEPERIODEO.PERIOD_NAME RES_PERIOD_NAME
,TO_CHAR(payTIMEPERIODEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(payTIMEPERIODEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,TO_CHAR(payTIMEPERIODEO.CUT_OFF_DATE,'DD-Mon-YYYY') RES_CUTOFF_DATE
,TO_CHAR(payTIMEPERIODEO.REGULAR_EARN_DATE,'DD-Mon-YYYY') RES_DATE_EARNED
,TO_CHAR(payTIMEPERIODEO.REGULAR_PROCESS_DATE,'DD-Mon-YYYY') RES_PAYROLL_RUN_DATE
,TO_CHAR(payTIMEPERIODEO.DEFAULT_PAYDATE,'DD-Mon-YYYY') RES_DATE_PAID
,TO_CHAR(payTIMEPERIODEO.PAYSLIP_VIEW_DATE,'DD-Mon-YYYY') RES_PAYSLIP_AVAILABILITY_DATE
,TO_CHAR(payTIMEPERIODEO.PROCESS_SUB_DATE,'DD-Mon-YYYY') RES_PLANNED_SUBMISSION_DATE

,payTIMEPERIODEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,payTIMEPERIODEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,payTIMEPERIODEO.CREATED_BY  RSC_CREATED_BY
,payTIMEPERIODEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_ALL_PAYROLLS_F payALLPREO
,PAY_TIME_PERIODS payTIMEPERIODEO
WHERE payALLPREO.PAYROLL_ID = payTIMEPERIODEO.PAYROLL_ID
AND SYSDATE BETWEEN payALLPREO.EFFECTIVE_START_DATE AND NVL(payALLPREO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND SYSDATE BETWEEN payTIMEPERIODEO.START_DATE AND NVL(payTIMEPERIODEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))