#!/bin/bash
# mra_sort_scan : v0.01 : Alexander Upton : 02/26/2021

# Copyright (c) 2021 Alexander Upton <alex.upton@gmail.com>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# You can download the latest version of this script from:
# https://github.com/alexanderupton/MiSTer-Scripts

# v0.01 : Alexander Upton : 02/26/2021 : Initial Release


# ========= IMMUTABLE ================

IFS=$'\n'
OIFS="$IFS"
OPTION=${1}
SWITCH=${2}

if [ "${SWITCH}" == "-v" ]; then
  export MKDIR_OPT="-pv"
  export LN_OPT="-sfv"
else
  export MKDIR_OPT="-p"
  export LN_OPT="-sf"
fi

# ========= OPTIONS ==================

MRA_PATH="/media/fat/_Arcade"
UPDATE_ALL_LOG="/media/fat/Scripts/.mister_updater/update_all.log"
VER="0.01"

# ========= USAGE ====================

USAGE(){
 echo
 echo "mra_sort_scan <option> <switch>"
 echo "options:"
 echo "   -bc : Create Sort-By-Core Directory Structure"
 echo "   -bm : Create Sort-By-Manufacturer Directory Structure"
 echo "   -by : Create Sort-By-Year Directory Structure"
 echo "   -mr : Create Most Recent Updates Directory Structure"
 echo 
 echo "switches:"
 echo "     -v : verbose output"
 echo
}

# ========= CODE STARTS HERE =========

SORT_BY_MFG() {

for MRA in $(find ${MRA_PATH} -type f -name "*.mra"); do
  MRA_NAME=$(basename "${MRA}")
  MRA_REAL=$(basename "${MRA}" | awk -F. {'print $1'})
  MFG_NAME=$(sed -ne '/manufacturer/{s/.*<manufacturer>\(.*\)<\/manufacturer>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
  CORE_NAME=$(sed -ne '/rbf/{s/.*<rbf>\(.*\)<\/rbf>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})

  case ${MFG_NAME} in
    [c..C]apcom*) CORE_DIR="Capcom" ;;
    [s..S]ega*|Coreland*|Escape) CORE_DIR="Sega" ;;
    [i..I]rem*) CORE_DIR="Irem" ;;
    [a..A]tari*) CORE_DIR="Atari" ;;
    [k..K]onami*) CORE_DIR="Konami" ;;
    [u..U]niversal*) CORE_DIR="Universal" ;;
    [c..C]AVE) CORE_DIR="CAVE" ;;
    [c..C]enturi) CORE_DIR="Centuri" ;;
    [n..N]intendo*) CORE_DIR="Nintendo" ;;
    [n..N]ichibutsu*) CORE_DIR="Nichibutsu" ;;
    [n..N]amco*) CORE_DIR="Namco" ;;
    [o..O]rca*) CORE_DIR="Orca" ;;
    "Duncan B"*) CORE_DIR="Duncan Brown" ;;
    [g..G]ottlieb*) CORE_DIR="Gottlieb" ;;
    "Alpha Denshi"*) CORE_DIR="Alpha Denshi" ;;
    [b..B]ootleg*) CORE_DIR="BOOTLEG" ;;
    UPL*) CORE_DIR="UPL" ;;
    [t..T]ecmo*) CORE_DIR="Tecmo" ;;
    [h..H]oei*) CORE_DIR="Hoei" ;;
    "Data East"*) CORE_DIR="Data East" ;;
    "Dave Nutting"*) CORE_DIR="Midway" ;; 
    [m..M]idway*) CORE_DIR="Midway" ;; 
    "Bally Midway"*) CORE_DIR="Bally Midway" ;;
    [t..T]aito*) CORE_DIR="Taito" ;;
    [t..T]ehkan) CORE_DIR="Tehkan" ;;
    [f..F]alcon) CORE_DIR="Falcon" ;;
    [t..T]echnos*) CORE_DIR="Technos" ;;
    [t..T]echstar*) CORE_DIR="Techstar" ;;
    [t..T]elko*) CORE_DIR="Telko" ;;
    [s..S]tern*) CORE_DIR="Stern" ;;
    [s..S]igma*) CORE_DIR="Sigma" ;;
    [s..S]yzygy*) CORE_DIR="Syzygy" ;;
    [i..I]tisa*) CORE_DIR="Itisa" ;;
    [v..V]aladon*) CORE_DIR="Valadon" ;;
    [w..W]illiams*) CORE_DIR="Williams" ;;
    "General Computer"*) CORE_DIR="GCC" ;;
    [r..R]ait*) CORE_DIR="Raid" ;;
    TDS*) CORE_DIR="TDS" ;;
    MTM*) CORE_DIR="MTM" ;;
    Vision*) CORE_DIR="Vision" ;;
    "Crazy Ivan"*) CORE_DIR="Crazy Ivan" ;;
    [c..C]omsoft*) CORE_DIR="Comsoft" ;;
    [s..S]ubelectro*) CORE_DIR="Subelectro" ;;
    [a..A]rmenia*) CORE_DIR="Armenia" ;;
    [e..E]pos*) CORE_DIR="Epos" ;;
    Mitchell*) CORE_DIR="Capcom" ;;
    [z..Z]ilec*) CORE_DIR="Zilec" ;;
    Kyoei*) CORE_DIR="Kyoei" ;;
    "Electronic Games Systems") CORE_DIR="Electronic Games Systems" ;;
  esac

  if [ ! -n "${CORE_DIR}" ]; then
    case ${CORE_NAME} in
     segasys*) CORE_DIR="Sega" ;;
     jtbubl*) CORE_DIR="Taito" ;;
     jtdd*) CORE_DIR="Technos" ;;
     jtpopey*) CORE_DIR="Nintendo" ;;
     jtcomsc|jtcontra) CORE_DIR="Konami" ;;
     jtcom*|jtf1*|jtgng*|jtgun*|jtsf|jthige|jtsarms|jtcps*|jttrojan|jt194*|jtbio*|jtbtig*|jtvulg*|jtsect*|jttor*) CORE_DIR="Capcom" ;;
    esac
  fi

  if [ -n "${CORE_DIR}" ]; then
    echo "Processing: ${MRA_REAL} - Manufacturer: ${CORE_DIR}"
    [[ ! -d ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}" ]] && mkdir ${MKDIR_OPT} ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}" 
    if [ ! -L ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}"/${MRA_NAME} ]; then
      ln ${LN_OPT} ${MRA} ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}"/${MRA_NAME}
    fi
  else
    [[ ${SWITCH} == "-v" ]] && "Malformed MRA : ${MRA} - CORE:${CORE_NAME} - CORE_DIR: ${CORE_DIR} - MANUFACTUER: ${MFG_NAME}"
  fi

  unset CORE_NAME CORE_DIR MFG_NAME
done

}

SORT_BY_CORE() {

for MRA in $(find ${MRA_PATH} -type f -name "*.mra"); do
  MRA_NAME=$(basename "${MRA}")
  MRA_REAL=$(basename "${MRA}" | awk -F. {'print $1'})
  CORE_NAME=$(sed -ne '/rbf/{s/.*<rbf>\(.*\)<\/rbf>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
  CORE_DIR=${CORE_NAME}

  if [ -n "${CORE_DIR}" ]; then
    echo "Processing: ${MRA_REAL} - Core: ${CORE_NAME}"
    [[ ! -d ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}" ]] && mkdir ${MKDIR_OPT} ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}"
    if [ ! -L ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}"/${MRA_NAME} ]; then
      ln ${LN_OPT} ${MRA} ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}"/${MRA_NAME}
    fi
  else
    [[ ${SWITCH} == "-v" ]] && "Malformed MRA : ${MRA} - CORE:${CORE_NAME} - CORE_DIR: ${CORE_DIR} - MANUFACTUER: ${MFG_NAME}"
  fi

  unset CORE_NAME CORE_DIR MFG_NAME
done

}

SORT_BY_YEAR() {

for MRA in $(find ${MRA_PATH} -type f -name "*.mra"); do
  MRA_NAME=$(basename "${MRA}")
  MRA_REAL=$(basename "${MRA}" | awk -F. {'print $1'})
  CORE_YEAR=$(sed -ne '/year/{s/.*<year>\(.*\)<\/year>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
  CORE_DIR=${CORE_YEAR}
  CORE_YEAR_RE='^[0-9]+$'

  if [[ ${CORE_YEAR} =~ ${CORE_YEAR_RE} ]]; then
    if [ -n "${CORE_DIR}" ]; then
      echo "Processing: ${MRA_REAL} - Year: ${CORE_YEAR}"
      [[ ! -d ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}" ]] && mkdir ${MKDIR_OPT} ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}"
      if [ ! -L ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}"/${MRA_NAME} ]; then
        ln ${LN_OPT} ${MRA} ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}"/${MRA_NAME}
      fi
    else
     [[ ${SWITCH} == "-v" ]] && echo "Malformed MRA : ${MRA} - CORE:${CORE_NAME} - CORE_DIR: ${CORE_DIR} - MANUFACTUER: ${MFG_NAME}"
    fi
  else
    echo
    echo "Error: ${MRA_REAL} - Year: ${CORE_YEAR}"
    echo
  fi
  unset CORE_NAME CORE_DIR CORE_YEAR
done

}

MOST_RECENT(){
MRA_RECENT_DIR=${MRA_PATH}/"_.Most Recent"
[[ ! -d "${MRA_RECENT_DIR}" ]] && mkdir ${MKDIR_OPT} "${MRA_RECENT_DIR}"

  UPDATE_SCAN(){
    for UPDATE in $(grep mra ${UPDATE_ALL_LOG}); do

      for MRA_NAME in $(echo $UPDATE | sed 's/, /\n/g'); do
        if [ -n "${MRA_NAME}" ]; then
          if [[ "${MRA_NAME}" == *.mra ]]; then
            export NEW_MRA="true"
            export NEW_MRA_LIST="${NEW_MRA_LIST} ${MRA_NAME}"

            if [ -f "${MRA_PATH}/${MRA_NAME}" ]; then
              MRA="${MRA_PATH}/${MRA_NAME}"

              if [ ! -L "${MRA_RECENT_DIR}/${MRA_NAME}" ]; then
                MFG_NAME=$(sed -ne '/manufacturer/{s/.*<manufacturer>\(.*\)<\/manufacturer>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
                CORE_NAME=$(sed -ne '/rbf/{s/.*<rbf>\(.*\)<\/rbf>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
      	        echo "Processing: ${MRA_NAME} - Manufacturer: ${MFG_NAME} - Core: ${CORE_NAME}"
	        ln ${LN_OPT} ${MRA} "${MRA_RECENT_DIR}/${MRA_NAME}"
              fi

            fi
          fi
        else
          echo "There have been no new MRA changes since the last update."  
        fi
        unset MRA_NAME MRA MFG_NAME CORE_NAME 

      done 
    done

    if [ "${NEW_MRA}" == "true" ]; then
      for CURRENT_MRA in ${MRA_RECENT_DIR}/*.mra; do
        MRA_NAME=$(basename ${CURRENT_MRA})
  
        if ! echo ${NEW_MRA_LIST} | grep -q ${MRA_NAME}; then
          rm -f "${MRA_NAME}"
        fi

      done

     fi
  }

  if grep -q mra ${UPDATE_ALL_LOG}; then
    UPDATE_SCAN
  else
    echo 
    echo "  There have been no new MRA changes since the last update."
    echo
  fi

}


case ${OPTION} in
 -bm) SORT_BY_MFG ;;
 -bc) SORT_BY_CORE ;;
 -by) SORT_BY_YEAR ;;
 -mr) MOST_RECENT ;;
 *) USAGE ;;
esac
