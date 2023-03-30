/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Cross-Charge%20Options.sql $:
* $Id: Manage Project Templates - Cross-Charge Options.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,buE0.BU_NAME RES_RECEIVER_BUSINESS_UNIT
,DECODE(projTemplatesE0.ALLOW_CROSS_CHARGE_FLAG,'Y','Yes','No') RES_ALLOW_CHARGES_FROM_ALL_PRO
,DECODE(projTemplatesE0.CC_PROCESS_LABOR_FLAG,'Y','Yes','No') RES_PROCESS_CROSS_CHARGE_TRANS
,(SELECT TP_SCHEDULE_NAME
	FROM PJF_TP_SCHEDULES
	WHERE TP_SCHEDULE_ID = projTemplatesE0.LABOR_TP_SCHEDULE_ID
	) RES_LABOR_TRANSFER_PRICE_SCHED
,TO_CHAR(projTemplatesE0.LABOR_TP_FIXED_DATE,'DD-Mon-YYYY') RES_LABOR_FIXED_DATE
,DECODE(projTemplatesE0.CC_PROCESS_NL_FLAG,'Y','Yes','No') RES_PROCESS_CROSS_CHARGE_TRA_0
,(SELECT TP_SCHEDULE_NAME
	FROM PJF_TP_SCHEDULES
	WHERE TP_SCHEDULE_ID = projTemplatesE0.NL_TP_SCHEDULE_ID
	) RES_NONLABOR_TRANSFER_PRICE_SC
,TO_CHAR(projTemplatesE0.NL_TP_FIXED_DATE,'DD-Mon-YYYY') RES_NONLABOR_FIXED_DATE
,projTemplatesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,projTemplatesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,projTemplatesE0.CREATED_BY  RSC_CREATED_BY
,projTemplatesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
ORDER BY projTemplatesE0.NAME