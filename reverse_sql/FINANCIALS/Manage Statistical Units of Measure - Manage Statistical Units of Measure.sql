/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Statistical%20Units%20of%20Measure%20-%20Manage%20Statistical%20Units%20of%20Measure.sql $:
* $Id: Manage Statistical Units of Measure - Manage Statistical Units of Measure.sql 53543 2016-03-15 08:46:40Z
pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT
	(SELECT name
	FROM FND_KF_STR_INSTANCES_VL
	WHERE STRUCTURE_INSTANCE_NUMBER = GLSTATACCOUNTUOM.CHART_OF_ACCOUNTS_ID
	)                                      AS RES_CHART_OF_ACCOUNTS
,GLSTATACCOUNTUOM.ACCOUNT_SEGMENT_VALUE AS RES_ACCOUNT
,NULL                                   AS RES_DESCRIPTION
,GLSTATACCOUNTUOM.UNIT_OF_MEASURE       AS RES_UNIT_OF_MEASURE
,GlStatAccountUom.DESCRIPTION           AS RES_UNIT_OF_MEASURE_DESCRIPTIO
,GLSTATACCOUNTUOM.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GLSTATACCOUNTUOM.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GLSTATACCOUNTUOM.CREATED_BY RSC_CREATED_BY
,GLSTATACCOUNTUOM.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,GLSTATACCOUNTUOM.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_STAT_ACCOUNT_UOM GLSTATACCOUNTUOM
ORDER BY RES_CHART_OF_ACCOUNTS 