/* ****************************************************************************
 * $Revision: 79472 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-10-10 13:47:36 +0700 (Mon, 10 Oct 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Mapping%20Set.sql $:
 * $Id: Manage Mapping Sets - Mapping Set.sql 79472 2022-10-10 06:47:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
select APPLICATIONPEO.application_name RES_SUBLEDGER_APPLICATION
,MAPPINGSETEO.name RES_NAME 
,MAPPINGSETEO.MAPPING_SET_CODE RES_SHORT_NAME
,DECODE(MAPPINGSETEO.FLEXFIELD_ASSIGN_MODE_CODE,'A','Account combination','S','Segment','Value set') RES_OUTPUT_TYPE
,MAPPINGSETEO.DESCRIPTION RES_DESCRIPTION
,DECODE(MAPPINGSETEO.ENABLED_FLAG,'Y','Active','Inactive') RES_STATUS
,(CASE
	WHEN MAPPINGSETEO.LAST_UPDATED_BY = 'SEED_DATA_FROM_APPLICATION' THEN
		NVL((SELECT LAST_UPDATED_BY
			FROM XLA_MAPPING_SET_VALUES
			WHERE MAPPING_SET_CODE = MAPPINGSETEO.MAPPING_SET_CODE
			AND APPLICATION_ID = MAPPINGSETEO.APPLICATION_ID
			AND AMB_CONTEXT_CODE = MAPPINGSETEO.AMB_CONTEXT_CODE
			AND LAST_UPDATED_BY != 'SEED_DATA_FROM_APPLICATION'
			AND ROWNUM = 1),'SEED_DATA_FROM_APPLICATION')
	ELSE	
		MAPPINGSETEO.LAST_UPDATED_BY
	END) RSC_LAST_UPDATED_BY
,MAPPINGSETEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,MAPPINGSETEO.CREATED_BY RSC_CREATED_BY
,MAPPINGSETEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from XLA_MAPPING_SETS_VL MAPPINGSETEO
,XLA_SUBLEDGERS_TL APPLICATIONPEO
where MAPPINGSETEO.APPLICATION_ID = APPLICATIONPEO.APPLICATION_ID(+)
AND APPLICATIONPEO.LANGUAGE = USERENV('LANG')
order by MAPPINGSETEO.name