/* ****************************************************************************
 * $Revision: 80185 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2023-02-16 16:49:42 +0700 (Thu, 16 Feb 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Value%20Sets.sql $:
 * $Id: Manage Mapping Sets - Value Sets.sql 80185 2023-02-16 09:49:42Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT APPLICATIONPEO.application_name RES_SUBLEDGER_APPLICATION
,MAPPINGSETEO.NAME RES_NAME
,MAPPINGSETEO.MAPPING_SET_CODE RES_SHORT_NAME
,DECODE(MAPPINGSETEO.FLEXFIELD_ASSIGN_MODE_CODE,'A','Account combination','S','Segment','Value set') RES_OUTPUT_TYPE
,ValueSetPEO.VALUE_SET_CODE RES_VALUE_SET
,(CASE
	WHEN MappingSetFlavorEO.LAST_UPDATED_BY = 'SEED_DATA_FROM_APPLICATION' THEN
		NVL((SELECT LAST_UPDATED_BY
			FROM XLA_MAPPING_SET_VALUES
			WHERE MAPPING_SET_CODE = MAPPINGSETEO.MAPPING_SET_CODE
			AND APPLICATION_ID = MAPPINGSETEO.APPLICATION_ID
			AND AMB_CONTEXT_CODE = MAPPINGSETEO.AMB_CONTEXT_CODE
			AND LAST_UPDATED_BY != 'SEED_DATA_FROM_APPLICATION'
			AND ROWNUM = 1),'SEED_DATA_FROM_APPLICATION')
	ELSE	
		MappingSetFlavorEO.LAST_UPDATED_BY
	END) RSC_LAST_UPDATED_BY
,MappingSetFlavorEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MappingSetFlavorEO.CREATED_BY RSC_CREATED_BY
,MappingSetFlavorEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_MAPPING_SETS_VL MAPPINGSETEO
,XLA_MAPPING_SET_FLAVORS MappingSetFlavorEO
,FND_KF_STR_INSTANCES_VL KfStructIns
,FND_VS_VALUE_SETS VALUESETPEO
,XLA_SUBLEDGERS_TL APPLICATIONPEO
WHERE MAPPINGSETEO.MAPPING_SET_CODE     = MappingSetFlavorEO.MAPPING_SET_CODE
AND(MappingSetFlavorEO.STRIPE_ID        = KfStructIns.STRUCTURE_INSTANCE_NUMBER(+))
AND(MappingSetFlavorEO.STRIPE_ID        = ValueSetPEO.VALUE_SET_ID(+)
AND((KfStructIns.APPLICATION_ID        IS NULL
AND KfStructIns.KEY_FLEXFIELD_CODE     IS NULL)
OR(KfStructIns.APPLICATION_ID           = 101
AND KfStructIns.KEY_FLEXFIELD_CODE      = 'GL#')))
AND MAPPINGSETFLAVOREO.AMB_CONTEXT_CODE = 'DEFAULT'
AND MAPPINGSETEO.APPLICATION_ID         = MAPPINGSETFLAVOREO.APPLICATION_ID
AND MAPPINGSETEO.FLEXFIELD_ASSIGN_MODE_CODE = 'V'
AND MAPPINGSETEO.APPLICATION_ID = APPLICATIONPEO.APPLICATION_ID(+)
AND APPLICATIONPEO.LANGUAGE = USERENV('LANG')
ORDER BY MAPPINGSETEO.NAME