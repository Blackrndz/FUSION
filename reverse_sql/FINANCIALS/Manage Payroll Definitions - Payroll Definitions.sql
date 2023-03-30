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
,(SELECT NAME FROM PER_LEGISLATIVE_DATA_GROUPS_VL 
	WHERE LEGISLATIVE_DATA_GROUP_ID = payALLPREO.LEGISLATIVE_DATA_GROUP_ID) RES_LEGISLATIVE_DATA_GROUP

,payALLPREO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,payALLPREO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,payALLPREO.CREATED_BY  RSC_CREATED_BY
,payALLPREO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_ALL_PAYROLLS_F payALLPREO
ORDER BY payALLPREO.PAYROLL_NAME,2
