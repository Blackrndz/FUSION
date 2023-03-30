/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT bSchedulsE0.IND_SCH_NAME RES_NAME
,bsVersionsE0.IND_RATE_SCH_REVISION RES_VERSION
,(SELECT NAME
	FROM HR_ALL_ORGANIZATION_UNITS
	WHERE ORGANIZATION_ID = bsMultipliersE0.ORGANIZATION_ID 
	) RES_ORGANIZATION
,bsMultipliersE0.IND_COST_CODE RES_BURDEN_COST_CODE
,(CASE
	WHEN INSTR(bsMultipliersE0.MULTIPLIER_NUM,'.',1,1) = 1 THEN 
		'0'||bsMultipliersE0.MULTIPLIER_NUM
	ELSE 
		TO_CHAR(bsMultipliersE0.MULTIPLIER_NUM)
	END) RES_MULTIPLIER
,bsMultipliersE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,bsMultipliersE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,bsMultipliersE0.CREATED_BY  RSC_CREATED_BY
,bsMultipliersE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_IND_RATE_SCH_VL bSchedulsE0
,PJF_IRS_REVISIONS bsVersionsE0
,PJF_IND_COST_MULTIPLIERS bsMultipliersE0
WHERE bSchedulsE0.IND_RATE_SCH_ID = bsVersionsE0.IND_RATE_SCH_ID
AND bsVersionsE0.IND_RATE_SCH_REVISION_ID = bsMultipliersE0.IND_RATE_SCH_REVISION_ID
ORDER BY bSchedulsE0.IND_SCH_NAME
,bsVersionsE0.IND_RATE_SCH_REVISION