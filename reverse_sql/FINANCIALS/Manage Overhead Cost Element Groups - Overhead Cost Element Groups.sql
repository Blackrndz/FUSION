/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT DECODE(CstElementGrpE0.COST_ORGANIZATION_ID,NULL,'All'
	,(SELECT NAME
		FROM HR_ORGANIZATION_V
		WHERE CLASSIFICATION_CODE = 'CST'
		AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		AND ORGANIZATION_ID = CstElementGrpE0.COST_ORGANIZATION_ID
		)
	) RES_COST_ORGANIZATION
,CstElementGrpE0.GROUP_CODE RES_GROUP_NAME
,CstElementGrpE0.GROUP_DESC RES_DESCRIPTION
,DECODE(CstElementGrpE0.INACTIVE_FLAG,'Y','Yes','No') RES_INACTIVE
,DECODE(CstElementGrpE0.IS_SEED,'Y','Yes','No') RES_SYSTEM_DEFINED
,CstElementGrpE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CstElementGrpE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CstElementGrpE0.CREATED_BY RSC_CREATED_BY
,CstElementGrpE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CstElementGrpE0.COST_ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ELEMENT_GRPS_VL CstElementGrpE0
ORDER BY DECODE(CstElementGrpE0.IS_SEED,'Y',1,2),1,2