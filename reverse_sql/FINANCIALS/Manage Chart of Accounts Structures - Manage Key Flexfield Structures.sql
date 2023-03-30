/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Structures%20-%20Manage%20Key%20Flexfield%20Structures.sql $:
 * $Id: Manage Chart of Accounts Structures - Manage Key Flexfield Structures.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

Select distinct HEAD.KEY_FLEXFIELD_CODE         RES_KEY_FLEXFIELD_CODE,
HEAD.NAME                       RES_KEY_FLEXFIELD_NAME,        
Detail.STRUCTURE_CODE           RES_STRUCTURE_CODE,
Detail.NAME                     RES_NAME,
Detail.DESCRIPTION              RES_DESCRIPTION,
Detail.DELIMITER                RES_DELIMITER,
decode(Detail.ENABLED_FLAG,'Y','Yes','No')        RES_ENABLED
,Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM 
  ( SELECT KeyFlexfieldEO.APPLICATION_ID,
    KeyFlexfieldEO.KEY_FLEXFIELD_CODE,
    KeyFlexfieldEO.MODULE_ID,
    KeyFlexfieldEO.NAME,
    KeyFlexfieldEO.BI_ENABLED_FLAG,
    KeyFlexfieldEO.DEPLOYMENT_STATUS,
    KeyFlexfieldEO.DEPLOYMENT_ERROR_MESSAGE,
    KeyFlexfieldEO.DEPLOYMENT_DATE,
    ApplTaxonomyPEO.MODULE_ID AS MODULE_ID1,
    ApplTaxonomyPEO.MODULE_TYPE,
    ApplTaxonomyPEO.MODULE_KEY,
    ApplTaxonomyPEO.USER_MODULE_NAME,
    ApplicationPEO.APPLICATION_ID AS APPLICATION_ID1,
    ApplicationPEO.APPLICATION_NAME,
    KeyFlexfieldEO.LAST_UPDATED_BY,
    KeyFlexfieldEO.LAST_UPDATE_DATE ,
    KeyFlexfieldEO.CREATED_BY,
	KeyFlexfieldEO.CREATION_DATE
  FROM Fusion.FND_KF_FLEXFIELDS_VL KeyFlexfieldEO,
       Fusion.FND_APPL_TAXONOMY_VL ApplTaxonomyPEO,
       Fusion.FND_APPLICATION_VL ApplicationPEO
  WHERE KeyFlexfieldEO.MODULE_ID    = ApplTaxonomyPEO.MODULE_ID
  AND KeyFlexfieldEO.APPLICATION_ID = ApplicationPEO.APPLICATION_ID
  AND (KeyFlexfieldEO.module_id    IN
    (SELECT rf.child_module_id
    FROM Fusion.fnd_appl_taxonomy_rf rf
    INNER JOIN Fusion.fnd_appl_taxonomy t
    ON rf.ancestor_module_id = t.module_id
    WHERE t.module_type      = 'APPLICATION'
    AND t.module_key         = 'GL'
    ))
  ) HEAD
,
  (SELECT KeyFlexfieldStructureEO.STRUCTURE_ID,
    KeyFlexfieldStructureEO.APPLICATION_ID,
    KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE,
    KeyFlexfieldStructureEO.STRUCTURE_CODE,
    KeyFlexfieldStructureEO.NAME,
    KeyFlexfieldStructureEO.ENABLED_FLAG,
    KeyFlexfieldStructureEO.DESCRIPTION,
    KeyFlexfieldStructureEO.DELIMITER,
    KeyFlexfieldStructureEO.LAST_UPDATED_BY,
    KeyFlexfieldStructureEO.LAST_UPDATE_DATE ,
    KeyFlexfieldStructureEO.CREATED_BY,
	KeyFlexfieldStructureEO.CREATION_DATE
  FROM Fusion.FND_KF_STRUCTURES_VL KeyFlexfieldStructureEO
  WHERE ( ( ( (KeyFlexfieldStructureEO.APPLICATION_ID = 101 )
  AND (KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE     = 'GL#' ) ) ) )
  ORDER BY KeyFlexfieldStructureEO.NAME
  ) Detail
,Fusion.FND_KF_SEGMENTS_VL KeyFlexfieldSegmentEO
,Fusion.FND_KF_LABELED_SEGMENTS KeyFlexfieldLabeledSegmentEO
WHERE HEAD.APPLICATION_ID  = Detail.APPLICATION_ID(+)
and  Detail.STRUCTURE_ID   = KeyFlexfieldSegmentEO.STRUCTURE_ID(+)
order by detail.NAME